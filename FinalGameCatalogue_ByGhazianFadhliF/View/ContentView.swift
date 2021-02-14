//
//  ContentView.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 29/12/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
  
  var body: some View {
    TabView{
      TopAndRatedView()
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
      FavoriteView()
        .tabItem {
          Image(systemName: "star.fill")
          Text("Favorite")
        }
      Search()
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
      ProfileView()
        .tabItem {
          Image(systemName: "person.crop.circle.fill")
          Text("Profile")
        } 
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
