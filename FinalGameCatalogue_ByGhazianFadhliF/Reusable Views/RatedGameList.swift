//
//  RatedGameList.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RatedGameList: View {
  @ObservedObject var games = APIServices()
  @State var didAppear = false
  
  var body: some View {
    
    ScrollView(.vertical, showsIndicators:false){
      VStack(alignment:.leading){
        Text("Highest Rating")
          .font(.largeTitle)
          .bold()
        if games.isLoading{
          Indicator()
        }else{
          ForEach(games.data){ i in
            NavigationLink(destination: GameDetails(id: Int(i.id))){
              HStack(alignment:.top){
                ZStack(alignment: .bottomLeading){
                  if i.image != ""{
                    AnimatedImage(url: URL(string: i.image)!)
                      .resizable()
                      .indicator(SDWebImageActivityIndicator.grayLarge)
                      .scaledToFill()
                      .frame(width: 100, height: 100)
                      .cornerRadius(10)
                      .shadow(radius:5)
                    
                    (Text(Image("myStar")) + Text(String(format: " %.2f", i.rating)))
                      .font(.system(size: 16))
                      .bold()
                      .foregroundColor(.white)
                      .padding(.all, 10)
                      .background(Color.black.opacity(0.7))
                      .cornerRadius(20)
                  }
                  else{
                    Image("dummyPhotos")
                      .resizable()
                      .scaledToFill()
                      .frame(width: 100, height: 100)
                      .cornerRadius(10)
                      .shadow(radius:5)
                  }
                }
                
                VStack(alignment: .leading){
                  Text(i.name)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color("myDarkBlue"))
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                  Text(i.released)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("myGray"))
                    .padding(.bottom, 2)
                  ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                      ForEach(i.genres.prefix(2), id: \.self){ items in
                        Text(items)
                          .font(.system(size: 14))
                          .fontWeight(.bold)
                          .foregroundColor(.white)
                          .padding(.init(top: 5, leading: 7, bottom: 5, trailing: 7))
                          .background(Color("myBlue"))
                          .cornerRadius(20)
                      }
                    }
                  }
                }
              }.padding(.all, 10)
            }
          }
        }
      }
    }
    .onAppear(perform: onLoad)
  }
  
  func onLoad() {
    if didAppear == false {
      games.fetchListGame("-rating")
    }
    didAppear = true
  }
}

struct RatedGameList_Previews: PreviewProvider {
  static var previews: some View {
    RatedGameList()
  }
}
