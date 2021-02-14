//
//  TopAndRatedView.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import SwiftUI

struct TopAndRatedView: View {
  var body: some View {
    NavigationView{
      List{
        TopGameList()
        RatedGameList()
      }
      .navigationBarTitle("Home")
    }
  }
}

struct TopAndRatedView_Previews: PreviewProvider {
  static var previews: some View {
    TopAndRatedView()
  }
}
