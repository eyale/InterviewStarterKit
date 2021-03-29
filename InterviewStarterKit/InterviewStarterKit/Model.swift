//
//  Model.swift
//  InterviewStarterKit
//
//  Created by Anton Honcharov on 3/29/21.
//

import Foundation

struct OctocatItem: Codable {
  var id: Int
  var name: String
  var description: String?

  var owner: Owner
}

struct Owner: Codable {
  var login: String
  var avatar_url: String
}


