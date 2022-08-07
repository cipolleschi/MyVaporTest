//
//  File.swift
//  
//
//  Created by Riccardo Cipolleschi on 06/08/2022.
//

import Foundation

public struct Profile: Codable {
  public let username: String
  public let name: String
  public let surname: String
  public let birthdate: String
  
  public init(
    username: String,
    name: String,
    surname: String,
    birthdate: String
  ) {
    self.username = username
    self.name = name
    self.surname = surname
    self.birthdate = birthdate
  }
  
  public var toJson: Data  {
    return try! JSONEncoder().encode(self)
  }
}
