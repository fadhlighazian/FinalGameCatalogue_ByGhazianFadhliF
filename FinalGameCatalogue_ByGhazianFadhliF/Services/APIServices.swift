//
//  APIServices.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 01/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class APIServices: ObservableObject{
  
  @Published var data = [Games]()
  @Published var screenshots = [Screenshots]()
  @Published var detail = Details()
  @Published var isLoading = true
  @Published var notFound = false
  @Published var query = ""
  
  private let baseURL = "https://api.rawg.io/api/games"
  
  // Fetch List Game Top & Rated
  func fetchListGame(_ order: String){
    let dates = getDate()
    guard var components = URLComponents(string: baseURL) else { fatalError("Invalid URL!") }
    components.queryItems = [
      URLQueryItem(name: "dates", value: dates),
      URLQueryItem(name: "ordering", value: order)
    ]
    let request = URLRequest(url: components.url!)
    
    AF.request(request).responseJSON { response in
      switch response.result{
      case .success(let value):
        
        self.isLoading = false
        
        let json = JSON(value)
        let items = json["results"].arrayValue
        
        for i in items{
          let id = i["id"].intValue
          let name = i["name"].stringValue
          let image = i["background_image"].stringValue
          let rating = i["rating"].doubleValue
          let released = self.dateFormat(i["released"].stringValue)
          let genres = i["genres"].arrayValue.map{$0["name"].stringValue}
          
          DispatchQueue.main.async{
            if !self.data.contains(Games(id: Int64(id), name: name, image: image, rating: rating, released: released, genres: genres)){
              self.data.append(Games(id: Int64(id), name: name, image: image, rating: rating, released: released, genres: genres))
            }
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // Fetch Detail
  func fetchDetail(_ id: Int){
    guard var url = URL(string: baseURL) else{ fatalError("Invalid URL!") }
    url.appendPathComponent("\(id)")
    let request = URLRequest(url: url)
    
    AF.request(request).responseJSON { response in
      switch response.result{
      case .success(let value):
        
        self.isLoading = false
        
        let json = JSON(value)
        let dates = self.dateFormat(json["released"].stringValue)
        let platform = self.changeIcon(json["parent_platforms"].arrayValue.map{$0["platform"]["name"].stringValue})
        let esrb = self.esrbIcon(json["esrb_rating"]["name"].stringValue)
        
        DispatchQueue.main.async{
          self.detail =
            Details(
              id: json["id"].intValue,
              name: json["name"].stringValue,
              image: json["background_image"].stringValue,
              rating: json["rating"].doubleValue,
              released: dates,
              description: json["description_raw"].stringValue,
              esrb: esrb,
              website: json["website"].stringValue,
              clip: json["clip"]["clip"].stringValue,
              genres: json["genres"].arrayValue.map{$0["name"].stringValue},
              publishers: json["publishers"].arrayValue.map{$0["name"].stringValue},
              developers: json["developers"].arrayValue.map{$0["name"].stringValue},
              platforms: platform
            )
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // Fetch Screenshots
  func fetchScreenshots(_ id: Int){
    let screenshots = "screenshots"
    guard var components = URL(string: "https://api.rawg.io/api/games/") else{ fatalError("Invalid URL!") }
    components.appendPathComponent("\(id)")
    components.appendPathComponent(screenshots)
    let request = URLRequest(url: components)
    
    AF.request(request).responseJSON { response in
      switch response.result{
      case .success(let value):
        
        self.isLoading = false
        
        let json = JSON(value)
        let items = json["results"].arrayValue
        
        for i in items{
          let id = i["id"].intValue
          let images = i["image"].stringValue
          
          DispatchQueue.main.async {
            self.screenshots.append(Screenshots(id: id, images: images))
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // Fetch Search
  func fetchSearch(){
    guard var components = URLComponents(string: baseURL) else{ fatalError("Invalid URL") }
    components.queryItems = [URLQueryItem(name: "search", value: query)]
    let request = URLRequest(url: components.url!)

    AF.request(request).responseJSON { response in
      switch response.result{
      case .success(let value):
        
        let json = JSON(value)
        let items = json["results"].arrayValue
        
        if items.isEmpty{
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.isLoading = false
            return self.notFound.toggle()
          }
        }
        else{
          self.isLoading = false
          for i in items{
            let id = i["id"].intValue
            let name = i["name"].stringValue
            let image = i["background_image"].stringValue
            let rating = i["rating"].doubleValue
            let released = self.dateFormat(i["released"].stringValue)
            let genres = i["genres"].arrayValue.map{$0["name"].stringValue}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
              if !self.data.contains(Games(id: Int64(id), name: name, image: image, rating: rating, released: released, genres: genres)){
                self.data.append(Games(id: Int64(id), name: name, image: image, rating: rating, released: released, genres: genres))
              }
            }
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
}
