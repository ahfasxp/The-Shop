//
//  NavigationHelper.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Foundation
import SwiftUI

class NavigationHelper {
  static func linkBuilder<Content: View>(
    destination: some View,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: destination) { content() }
  }
}
