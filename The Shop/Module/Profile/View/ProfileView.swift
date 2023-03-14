//
//  ProfileView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      header
        .padding(.bottom, 18)
      profileCard
//      listMenu
      Spacer()
    }
  }
}

extension ProfileView {
  private var header: some View {
    HStack {
      Spacer()
      Text("Profile")
        .font(.title)
        .fontWeight(.semibold)
      Spacer()
//      Image(systemName: "rectangle.portrait.and.arrow.right")
//        .resizable()
//        .scaledToFit()
//        .frame(width: 24, height: 24)
    }
    .padding()
  }

  private var profileCard: some View {
    HStack(alignment: .top, spacing: 0.0) {
      Image("ahfas")
        .resizable()
        .scaledToFill()
        .frame(width: 80, height: 80)
        .cornerRadius(50)
        .padding(.trailing, 20)

      VStack(alignment: .leading, spacing: 0.0) {
        Text("Muchamad Ahfas Fazria")
          .font(.system(size: 20))
          .fontWeight(.bold)
          .padding(.bottom, 5)

        Text("ahfas.fazria@gmail.com")
          .font(.system(size: 14))
          .fontWeight(.regular)
          .foregroundColor(.gray)
          .padding(.bottom, 5)
      }
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 10)
  }

  private var listMenu: some View {
    VStack(alignment: .leading, spacing: 15) {
      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 80)
          .foregroundColor(.white)
          .shadow(radius: 3)

        HStack(alignment: .center, spacing: 0.0) {
          VStack(alignment: .leading, spacing: 0.0) {
            Text("My Orders")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .padding(.bottom, 5)

            Text("Already have 10 orders")
              .font(.system(size: 12))
              .fontWeight(.regular)
              .foregroundColor(.gray)
          }
          Spacer()
          Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
      }

      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 80)
          .foregroundColor(.white)
          .shadow(radius: 3)

        HStack(alignment: .center, spacing: 0.0) {
          VStack(alignment: .leading, spacing: 0.0) {
            Text("Shipping Addresses")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .padding(.bottom, 5)

            Text("03 Addresses")
              .font(.system(size: 12))
              .fontWeight(.regular)
              .foregroundColor(.gray)
          }
          Spacer()
          Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
      }

      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 80)
          .foregroundColor(.white)
          .shadow(radius: 3)

        HStack(alignment: .center, spacing: 0.0) {
          VStack(alignment: .leading, spacing: 0.0) {
            Text("Payment Method")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .padding(.bottom, 5)

            Text("You have 2 cards")
              .font(.system(size: 12))
              .fontWeight(.regular)
              .foregroundColor(.gray)
          }
          Spacer()
          Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
      }

      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 80)
          .foregroundColor(.white)
          .shadow(radius: 3)

        HStack(alignment: .center, spacing: 0.0) {
          VStack(alignment: .leading, spacing: 0.0) {
            Text("My Reviews")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .padding(.bottom, 5)

            Text("Reviews for 5 items")
              .font(.system(size: 12))
              .fontWeight(.regular)
              .foregroundColor(.gray)
          }
          Spacer()
          Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
      }

      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 80)
          .foregroundColor(.white)
          .shadow(radius: 3)

        HStack(alignment: .center, spacing: 0.0) {
          VStack(alignment: .leading, spacing: 0.0) {
            Text("Setting")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .padding(.bottom, 5)

            Text("Notification, Password, FAQ, Contact")
              .font(.system(size: 12))
              .fontWeight(.regular)
              .foregroundColor(.gray)
          }
          Spacer()
          Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
      }
    }
    .padding(20)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
