//
//  Utility.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import Foundation
import SwiftUI

extension APIServices{
  // Get Date (from past 1 year to current) 
  func getDate() -> String{
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let currentDate = format.string(from: date)
    
    let date2 = Calendar.current.date(byAdding: .year, value: -1, to: date)
    let pastDate = format.string(from: date2!)
    let rangeDate = "\(pastDate),\(currentDate)"
    
    return rangeDate
  }
  
  // Change Date Format
  func dateFormat(_ released: String) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date: Date? = dateFormatter.date(from: released)
    
    guard let getdate = date else { return "No date defined" }
    
    dateFormatter.dateStyle = .short
    dateFormatter.dateFormat = "MMMM d, yyyy"
    let dates = dateFormatter.string(from: getdate)
    
    return dates
  }
  
  // Change Parent Platform with Icon
  func changeIcon(_ arrP: [String]) -> [UIImage]{
    var platform = [UIImage]()
    for items in arrP{
      switch items {
      case "PC":
        platform.append(UIImage(named: "PC")!)
      case "PlayStation":
        platform.append(UIImage(named: "PS")!)
      case "Xbox":
        platform.append(UIImage(named: "XBOX")!)
      case "iOS":
        platform.append(UIImage(named: "IOS")!)
      case "Android":
        platform.append(UIImage(named: "ANDROID")!)
      case "Apple Macintosh":
        platform.append(UIImage(named: "APPLE")!)
      case "Linux":
        platform.append(UIImage(named: "LINUX")!)
      case "Nintendo":
        platform.append(UIImage(named: "NINTENDO")!)
      case "Atari":
        platform.append(UIImage(named: "ATARI")!)
      case "Commodore / Amiga":
        platform.append(UIImage(named: "AMIGA")!)
      case "SEGA":
        platform.append(UIImage(named: "SEGA")!)
      case "3DO":
        platform.append(UIImage(named: "3DO")!)
      case "Neo Geo":
        platform.append(UIImage(named: "NEOGEO")!)
      case "Web":
        platform.append(UIImage(named: "WEB")!)
      default:
        platform.append(UIImage(named: "PC")!)
      }
    }
    return platform
  }
  
  // Change esrb rating with Icon
  func esrbIcon(_ esrb: String) -> UIImage {
    var myEsrb = UIImage()
    switch esrb {
    case "Everyone":
      myEsrb = UIImage(named: "E")!
    case "Everyone 10+":
      myEsrb = UIImage(named: "E10")!
    case "Teen":
      myEsrb = UIImage(named: "T")!
    case "Mature":
      myEsrb = UIImage(named: "M")!
    case "Adults Only":
      myEsrb = UIImage(named: "AO")!
    case "Rating Pending":
      myEsrb = UIImage(named: "RP")!
    default:
      myEsrb = UIImage(named: "RP")!
    }
    return myEsrb
  }
}
