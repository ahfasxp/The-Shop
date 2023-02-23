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
  @EnvironmentObject var favoritePresenter: FavoritePresenter

  var body: some View {
    NavigationView {
      TabView {
        HomeView(
          homePresenter: homePresenter,
          cartPresenter: cartPresenter
        )
        .tabItem {
          Label("", systemImage: "house")
        }

        FavoriteView(
          favoritePresenter: favoritePresenter,
          cartPresenter: cartPresenter
        )
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
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let homePresenter = Injection().homePresenter()
    let cartPresenter = Injection().cartPresenter()
    ContentView()
      .environmentObject(homePresenter)
      .environmentObject(cartPresenter)
  }
}
