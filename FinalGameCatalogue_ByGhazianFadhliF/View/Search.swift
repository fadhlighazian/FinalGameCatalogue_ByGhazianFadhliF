//
//  Search.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 08/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Search: View {
  @ObservedObject var searchData = APIServices()
  @State var isSearching = false
  
  var body: some View {
    
    NavigationView{
      VStack{
        //Section searchBar
        HStack{
          HStack(spacing: 12){
            TextField("Search here..", text: $searchData.query).padding(.leading, 32)
          }.padding(8)
          .background(Color(.systemGray5))
          .cornerRadius(10)
          .padding()
          .overlay(
            HStack{
              Image(systemName: "magnifyingglass")
              Spacer()
              if searchData.query != ""{
                Button(action:{
                  searchData.query = ""
                }, label:{
                  Image(systemName: "xmark.circle.fill")
                    .padding(.vertical)
                })
              }
            }
            .padding(.horizontal, 32)
            .foregroundColor(.gray)
          )
          
          if searchData.query != ""{
            Button(action:{
              searchData.query = ""
            }, label:{
              Text("Cancel")
                .padding(.trailing)
                .padding(.leading, 0)
            })
          }
        }
        
        // Section Result
        if searchData.query.isEmpty{
          Spacer()
          Image("noResult")
          Spacer()
        }else{
          if searchData.isLoading{
            Indicator()
            Spacer()
          }else{
        List(searchData.data.filter {
          self.searchData.query.isEmpty ? true : $0.name.lowercased().contains(self.searchData.query.lowercased())
        }, id: \.self) { i in
          NavigationLink(destination: GameDetails(id: Int(i.id))){
            HStack(alignment:.top){
              ZStack(alignment: .bottomLeading){
                if i.image != ""{
                  AnimatedImage(url: URL(string: i.image))
                    .resizable()
                    .indicator(SDWebImageActivityIndicator.grayLarge)
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .shadow(radius:5)
                  
                  if i.rating != 0{
                    (Text(Image("myStar")) + Text(String(format: " %.2f", i.rating)))
                      .font(.system(size: 16))
                      .bold()
                      .foregroundColor(.white)
                      .padding(.all, 10)
                      .background(Color.black.opacity(0.7))
                      .cornerRadius(20)
                  }else{
                    Text("")
                  }
                }
                else{
                  Image("dummyPhotos3")
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
                  .padding(.bottom, 2)
                Text(i.released)
                  .font(.system(size: 16))
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
        }.listStyle(PlainListStyle())
          }
      }
      }
      .navigationBarTitle(Text("Search"))
    }
    
    .onChange(of: searchData.query, perform: { value in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        if value == searchData.query{
          if searchData.query != ""{
            searchData.fetchSearch()
          }else{
            searchData.data.removeAll()
            searchData.isLoading = true
          }
        }
      }
    })
    .alert(isPresented: $searchData.notFound){
      Alert(title: Text("No Result"), message: Text("Game not found"), dismissButton: .default(Text("OK")))
    }
  }
}

struct Search_Previews: PreviewProvider {
  static var previews: some View {
    Search()
  }
}
