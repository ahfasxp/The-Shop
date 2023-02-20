//
//  ContentView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("", systemImage: "house")
        }

      HomeView()
        .tabItem {
          Label("", systemImage: "bookmark")
        }

      HomeView()
        .tabItem {
          Label("", systemImage: "bell")
        }

      HomeView()
        .tabItem {
          Label("", systemImage: "person")
        }
    }
    .accentColor(.black)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
