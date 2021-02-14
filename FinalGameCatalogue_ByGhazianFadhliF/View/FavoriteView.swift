//
//  FavoriteView.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 05/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct FavoriteView: View {
  
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.name, ascending: false)]
  ) var favGames: FetchedResults<Favorite>
  
  var body: some View {
    NavigationView{
      List{
        ForEach(favGames, id: \.self) { i in
          //Batas
          NavigationLink(destination: GameDetails(id: Int(i.id))){
            HStack(alignment:.top){
              ZStack(alignment: .bottomLeading){
                if i.image != ""{
                  WebImage(url: URL(string: i.image ?? "")!)
                    .resizable()
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
                Text(i.name ?? "No name defined")
                  .font(.system(size: 16))
                  .fontWeight(.bold)
                  .foregroundColor(Color("myDarkBlue"))
                  .padding(.top, 2)
                  .padding(.bottom, 2)
                Text(i.released ?? "No date defined")
                  .font(.system(size: 15))
                  .fontWeight(.semibold)
                  .foregroundColor(Color("myGray"))
                  .padding(.bottom, 2)
              }
            }.padding(.all, 10)
          }
          //Batas
        }
        .onDelete(perform: deleteGame)
      }
      .navigationBarTitle("Favorites")
    }
  }
  
  // Delete Game in Core Data
  func deleteGame(at offsets: IndexSet) {
    offsets.forEach { index in
      let game = self.favGames[index]
      self.managedObjectContext.delete(game)
    }
    do {
      try managedObjectContext.save()
    } catch {
      print("Error saving managed object context: \(error)")
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView()
  }
}
