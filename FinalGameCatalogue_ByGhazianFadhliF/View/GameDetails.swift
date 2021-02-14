//
//  GameDetails.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit
import CoreData

struct GameDetails: View {
  
  var id: Int
  @ObservedObject var games = APIServices()
  @Environment(\.managedObjectContext) var managedObjectContext
  @State var showsAlert = false
  @State var isClicked = false
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false){
      VStack(alignment: .leading){
        
        if games.isLoading{
          VStack{
            Indicator()
            Text("Please wait..")
              .foregroundColor(.white)
          }.padding()
          .background(Color.black.opacity(0.5))
          .cornerRadius(20)
          .shadow(color: Color.secondary, radius: 20)
        }
        else{
          
          // Group of Title, Realeased, Rating
          HStack{
            VStack(alignment:.leading){
              HStack(alignment:.top){
                ZStack(alignment:.bottomLeading){
                  if games.detail.image != ""{
                    WebImage(url: URL(string: games.detail.image))
                      .resizable()
                      .indicator(.activity)
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 120, height: 150)
                      .cornerRadius(10)
                      .shadow(radius: 5)
                      .padding(.trailing)
                  }else{
                    Image("dummyPhotos3")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 120, height: 150)
                      .cornerRadius(10)
                      .shadow(radius: 5)
                      .padding(.trailing)
                  }
                  Image(uiImage: games.detail.esrb)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 50)
                }
                
                VStack(alignment: .leading){
                  Text(games.detail.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal:false, vertical:true)
                  Text(games.detail.released)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("myGray"))
                    .padding(.bottom, 2)
                  
                  ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                      ForEach(games.detail.platforms, id: \.self){ items in
                        Image(uiImage: items)
                      }
                    }.padding(.leading, 10)
                  }
                  
                  HStack{
                    switch games.detail.rating{
                    case 1.0...1.99:
                      (Text(Image("myStar")) + Text(String(format: " %.2f", games.detail.rating)))
                        .modifier(RatingStyle())
                    case 2.0...2.99:
                      (Text(Image("myStar2")) + Text(String(format: " %.2f", games.detail.rating)))
                        .modifier(RatingStyle())
                    case 3.0...3.99:
                      (Text(Image("myStar3")) + Text(String(format: " %.2f", games.detail.rating)))
                        .modifier(RatingStyle())
                    case 4.0...4.5:
                      (Text(Image("myStar4")) + Text(String(format: " %.2f", games.detail.rating)))
                        .modifier(RatingStyle())
                    case 4.5...5.0:
                      (Text(Image("myStar5")) + Text(String(format: " %.2f", games.detail.rating)))
                        .modifier(RatingStyle())
                    default:
                      Text("")
                    }
                  }
                }
              }
              HStack{
                if !isClicked{
                  Button(action: {
                    addGame(Int64(games.detail.id), games.detail.name, games.detail.image, games.detail.rating, games.detail.released) {
                      DispatchQueue.main.async {
                        isClicked = true
                        self.showsAlert.toggle()
                      }
                    }
                  }) {
                    Text("Add to favorite")
                      .font(.system(size: 14))
                      .fontWeight(.bold)
                      .foregroundColor(Color("myBlue"))
                      .frame(maxWidth:.infinity, alignment: .center)
                  }
                  .padding(.all,7)
                  .frame(maxWidth:.infinity, alignment:.topLeading)
                  .background(Color(.yellow))
                  .cornerRadius(5)
                }else{
                  Button(action: {})
                  {
                    Text("Has been added to favorite")
                      .font(.system(size: 14))
                      .fontWeight(.bold)
                      .foregroundColor(Color("myBlue"))
                      .frame(maxWidth:.infinity, alignment: .center)
                  }.disabled(true)
                  .padding(.all,7)
                  .frame(maxWidth:.infinity, alignment:.topLeading)
                  .background(Color("myGray"))
                  .cornerRadius(5)
                }
              }
            }
            
          }.padding(.all,20)
          .frame(maxWidth:.infinity, alignment:.topLeading)
          .background(Color("myDarkBlue"))
          .cornerRadius(10)
          
          
          //Group Pictures
          VStack(alignment: .leading){
            Text("Pictures")
              .font(.title2)
              .bold()
            ScrollView(.horizontal, showsIndicators: false){
              HStack{
                if games.detail.clip != ""{
                  Player(data: $games.detail.clip)
                    .frame(width: 260, height: 160)
                    .cornerRadius(10)
                }
                ForEach(games.screenshots, id: \.self){ i in
                  AnimatedImage(url: URL(string: i.images))
                    .resizable()
                    .indicator(SDWebImageActivityIndicator.grayLarge)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 260, height: 160)
                    .cornerRadius(10)
                }
              }
            }
          }.padding(.top, 20)
          //End of Group Pictures
          
          //Group Description
          VStack(alignment: .leading){
            Text("About this game")
              .font(.title2)
              .bold()
              .padding(.bottom, 10)
            Text(games.detail.description)
              .font(.body)
            ScrollView(.horizontal, showsIndicators: false){
              HStack{
                ForEach(games.detail.genres, id: \.self){ items in
                  Text(items)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.init(top: 5, leading: 7, bottom: 5, trailing: 7))
                    .background(Color("myBlue"))
                    .cornerRadius(10)
                }
              }
            }
          }.padding(.top, 20)
          //End of Group Description
          
          //Group Information
          VStack(alignment:.leading){
            Text("Additionals information")
              .font(.title2)
              .bold()
              .padding(.bottom, 10)
            Text("Website: ")
              .bold()
            Text(games.detail.website)
              .font(.body)
              .foregroundColor(Color.gray)
            Text("Developer(s): ")
              .bold()
              .padding(.top, 10)
            ForEach(games.detail.developers, id: \.self){ items in
              Text(items)
                .foregroundColor(Color.gray)
            }
            Text("Publishers(s): ")
              .font(.body)
              .bold()
              .padding(.top, 10)
            ForEach(games.detail.publishers, id: \.self){ items in
              Text(items)
                .font(.body)
                .foregroundColor(Color.gray)
            }
          }.padding(.top)
          //End of Group Description
          
        }
      }
    }.padding(.all)
    .alert(isPresented: $showsAlert){
      Alert(title: Text("Success!"), message: Text("\"\(games.detail.name)\" has been added to favorite"), dismissButton: .default(Text("OK")))
    }
    .onAppear(){
      games.fetchDetail(id)
      games.fetchScreenshots(id)
      checkExistingData(Int64(id))
    }
    .navigationBarTitle("Detail Games")
  }
  
  func checkExistingData(_ id: Int64){
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
    fetchRequest.predicate = NSPredicate(format: "id = %d", id)
    do {
      let test = try managedObjectContext.fetch(fetchRequest)
      if test.count == 1 {
        isClicked = true
      }
    } catch {
      print(error)
    }
  }
  
  func addGame(_ id: Int64, _ name: String, _ image: String, _ rating: Double, _ released: String, completion: @escaping() -> ()){
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
    fetchRequest.predicate = NSPredicate(format: "id = %d", id)
    
    do {
      let test = try managedObjectContext.fetch(fetchRequest)
      if test.count < 1 {
        managedObjectContext.performAndWait {
          if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedObjectContext) {
            let game = NSManagedObject(entity: entity, insertInto: managedObjectContext)
            game.setValue(id, forKeyPath: "id")
            game.setValue(name, forKeyPath: "name")
            game.setValue(image, forKeyPath: "image")
            game.setValue(rating, forKeyPath: "rating")
            game.setValue(released, forKeyPath: "released")
            do {
              try managedObjectContext.save()
              completion()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
          }
        }
      }
    } catch {
      print(error)
    }
  }
  
}

struct GameDetails_Previews: PreviewProvider {
  static var previews: some View {
    GameDetails(id: 41494)
  }
}


