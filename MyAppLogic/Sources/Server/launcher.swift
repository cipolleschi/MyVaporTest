//
//  File.swift
//  
//
//  Created by Riccardo Cipolleschi on 06/08/2022.
//

import Foundation
import Vapor

public func serverLauncher() throws {
  var env = try Environment.detect()
  try LoggingSystem.bootstrap(from: &env)
  let app = Application(env)
  defer { app.shutdown() }
  try configure(app)
  try app.run()
}
