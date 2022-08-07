//
//  SwiftUIView.swift
//  
//
//  Created by Riccardo Cipolleschi on 06/08/2022.
//

import SwiftUI
import Combine
import Logic

struct DataRow: View {
  var label: String
  var value: String
  
  var body: some View {
    HStack {
      Text(label)
      Spacer()
      Text(value)
    }.padding()
  }
}

public struct ContentView: View {
  @State var username: String = ""
  @State var profile: Profile? = nil
  
  public init() {}
  
  public var body: some View {
    VStack {
      TextField("Username", text: $username)
        .padding()
      Button("Search") {
        Task.detached {
          await self.search()
        }
      }
      Divider()
      Spacer()
      VStack {
        DataRow(label: "Name:", value: profile?.name ?? "")
        DataRow(label: "Surname:", value: profile?.surname ?? "")
        DataRow(label: "Date of Birth:", value: profile?.birthdate ?? "")
        Spacer()
      }
      .padding()
      .opacity(self.profile == nil ? 0 : 1)
    }
  }
  
  func search() async {
    let url = URL(string: "http://127.0.0.1:8080/profile/\(username)")!
    
    do {
      let data = try await URLSession.shared.data(from: url).0
      self.profile = try JSONDecoder().decode(Profile.self, from: data)
    } catch {
      print(error)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .previewDevice("iPhone 13")
    }
}
