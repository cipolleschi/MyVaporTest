import Vapor
import Logic
import Network

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
  
  app.get("profile", ":username") { req async -> Response in
    guard let username = req.parameters.get("username") else {
      return .init(status: .badRequest)
    }
    
    if username != "cipolleschi" {
        return .init(status: .forbidden)
    }

    let profile = Profile(username: username, name: "Riccardo", surname: "Cipolleschi", birthdate: "11/04/1988")
    return .init(status: .ok, body: .init(data: profile.toJson))
  }
}
