//
//  ViewController.swift
//  InterviewStarterKit
//
//  Created by Anton Honcharov on 3/28/21.
//

import UIKit

class MainViewController: UIViewController {
  // MARK: - Properties
  var list = [OctocatItem]()

  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
}

extension MainViewController {
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "StarterKit"

    fetchData(from: K.url)
    setupTableView()
  }
}

// MARK: - Set up
extension MainViewController {
  func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
}
// MARK: - IBActions
// MARK: - Navigation
extension MainViewController {
  func navigateTo(screen: String) {
    print("\n\n", #function, screen)
  }
}
// MARK: - Network Manager calls
extension MainViewController {
  func fetchData(from url: String) {
    guard let url = URL(string: url) else { return }
    var request = URLRequest(url: url)
//    let params: [String: String] = [:]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: params,
//                                                   options: [])

    request.httpMethod = K.RequestMethods.get.rawValue
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else { return }

      do {
        let responseModel = try JSONDecoder().decode([OctocatItem].self, from: data)
        self.list = responseModel

        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } catch {
        print("Parsing response Error: \(error)", "\n")
      }

      if let responseError = error {
        print("Api call Error: \(responseError)", "\n")
      }
    }
    task.resume()
  }
}
// MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int { list.count }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellItem.mainCellId) as! CellItem
    let item = list[indexPath.row]
    cell.configure(with: item)

    return cell
  }
}
