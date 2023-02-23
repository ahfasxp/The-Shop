//
//  The_ShopApp.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import SwiftUI

@main
struct MainView: App {
  let homePresenter = Injection().homePresenter()
  let cartPresenter = Injection().cartPresenter()
  let favoritePresenter = Injection().favoritePresenter()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(cartPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
