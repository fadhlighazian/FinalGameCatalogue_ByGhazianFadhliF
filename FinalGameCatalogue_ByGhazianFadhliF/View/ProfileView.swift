//
//  ProfileView.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
      NavigationView{
          ScrollView(.vertical, showsIndicators:false){
              VStack{
                  Image("myPhoto")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 200, height: 200)
                      .cornerRadius(20)
                      .overlay(
                          RoundedRectangle(cornerRadius: 20)
                              .stroke(Color.white, lineWidth: 5)
                      )
                      .shadow(radius: 5)
                      .padding()
                  
                  Text("Ghazian Fadhli Fakhrusy")
                      .font(.title2)
                      .fontWeight(.heavy)
                  
                  Text("Jakarta, Indonesia")
                      .font(.callout)
                      .foregroundColor(Color(.systemGray))
                      .padding(.bottom)
                  
                  Text("Contact")
                      .font(.title2)
                      .fontWeight(.heavy)
                  
                  Text("☎️ +6287-880-186-464\n📧 fadhlighazian@gmail.com")
                      .font(.callout)
                      .foregroundColor(Color(.systemGray))
                      .multilineTextAlignment(.center)
                      .padding(.bottom)
                  
                  
                  Text("About Fadhli")
                      .font(.title2)
                      .fontWeight(.heavy)
                  
                  Text("Fadhli’s a graduate of Informatics Engineering at Multimedia Nusantara University. He loves learning things about iOS Development and other technologies.")
                      .padding(.horizontal, 30)
                      .font(.callout)
                      .foregroundColor(Color(.systemGray))
                      .multilineTextAlignment(.center)
                  Spacer()
              }
          }
          .navigationBarTitle("My Profile")
      }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
