//
//  ContentView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var cartPresenter: CartPresenter

  var body: some View {
    TabView {
      HomeView(
        homePresenter: homePresenter,
        cartPresenter: cartPresenter)
        .tabItem {
          Label("", systemImage: "house")
        }

      FavoriteView(cartPresenter: cartPresenter)
        .tabItem {
          Label("", systemImage: "heart")
        }

      NotificationView()
        .tabItem {
          Label("", systemImage: "bell")
        }

      ProfileView()
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
