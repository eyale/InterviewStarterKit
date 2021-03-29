//
//  CellItem.swift
//  InterviewStarterKit
//
//  Created by Anton Honcharov on 3/29/21.
//

import UIKit

// MARK: - Cell Protocol
@objc protocol CellItemProtocol: NSObjectProtocol {
  func onCellPress(_ cell: CellItem)
}

class CellItem: UITableViewCell {
  // MARK: - Properties
  static let mainCellId = "TableCell"
  // MARK: - IBOutlets
  @IBOutlet weak var avatar: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
}
// MARK: - Life cycle
extension CellItem {
  override func awakeFromNib() {}
}

// MARK: - Set up
extension CellItem {
  func configure(with data: OctocatItem)  {
    avatar.load(from: data.owner.avatar_url)
    name.text = "Repository: \(data.name)"
    descriptionLabel.text = data.description
  }
}
// MARK: - IBActions
// MARK: - Navigation
// MARK: - Network Manager calls
// MARK: - Extensions
