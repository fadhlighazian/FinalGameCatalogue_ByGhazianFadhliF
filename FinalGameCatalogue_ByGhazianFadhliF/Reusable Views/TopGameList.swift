//
//  TopGameList.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct TopGameList: View {
  @ObservedObject var games = APIServices()
  @State var didAppear = false
  
  var body: some View {
    
    ScrollView(.horizontal, showsIndicators:false){
      HStack{
        if games.isLoading{
          Indicator()
        }else{
          ForEach(games.data){ i in
            NavigationLink(destination: GameDetails(id: Int(i.id))){
              ZStack(alignment: .bottomLeading){
                if i.image != ""{
                  AnimatedImage(url: URL(string: i.image)!)
                    .resizable()
                    .indicator(SDWebImageActivityIndicator.grayLarge)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 280, height: 250)
                    .cornerRadius(10)
                  
                  VStack{
                    Text(i.name)
                      .font(.title3)
                      .bold()
                      .frame(width: 250, height:60, alignment: .center)
                      .padding(.all,5)
                      .foregroundColor(Color.white)
                      .multilineTextAlignment(.center)
                      .fixedSize(horizontal:false, vertical:true)
                  }.padding(.all, 10)
                  .background(Color.black.opacity(0.5))
                  .cornerRadius(10)
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
              .shadow(radius: 5)
              .padding(.all, 10)
            }
          }
        }
      }
    }
    
    .onAppear(perform: onLoad)
  }
  
  func onLoad() {
    if didAppear == false {
      games.fetchListGame("-added")
    }
    didAppear = true
  }
}


struct TopGameList_Previews: PreviewProvider {
  static var previews: some View {
    TopGameList()
  }
}
