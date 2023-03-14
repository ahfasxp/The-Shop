//
//  NotificationView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import SwiftUI

struct NotificationView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      header
      listNotif
    }
  }
}

extension NotificationView {
  private var header: some View {
    HStack {
//      Image("icon-search")
//        .resizable()
//        .scaledToFit()
//        .frame(width: 24, height: 24)
      Spacer()

      Text("Notification")
        .font(.title)
        .fontWeight(.semibold)
      Spacer()
    }
    .padding()
  }

  private var listNotif: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 0.0) {
        notifCard
      }
    }
  }

  private var notifCard: some View {
    HStack(alignment: .top, spacing: 0.0) {
      Image("item")
        .resizable()
        .scaledToFill()
        .frame(width: 100, height: 100)
        .clipped()
        .cornerRadius(10)
        .padding(.trailing, 20)

      VStack(alignment: .leading, spacing: 0.0) {
        Text("Your order #123456789 has been shipped successfully")
          .font(.system(size: 12))
          .fontWeight(.bold)
          .lineLimit(2)
          .padding(.bottom, 5)

        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis pretium et in arcu adipiscing nec. Turpis pretium et in arcu adipiscing nec.")
          .font(.system(size: 10))
          .fontWeight(.regular)
          .foregroundColor(.gray)
          .padding(.bottom, 5)
      }
    }
    .frame(height: 100)
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
  }
}

struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationView()
  }
}
