//
//  Games.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 01/01/21.
//

import Foundation
import SwiftUI

struct Games: Identifiable, Hashable{
  var id: Int64 = 0
  var name: String = ""
  var image: String = ""
  var rating: Double = 0
  var released: String = ""
  var genres = [String]()
}

struct Details: Identifiable, Hashable{
  var id: Int = 0
  var name: String = ""
  var image: String = ""
  var rating: Double = 0
  var released: String = ""
  var description: String = ""
  var esrb = UIImage()
  var website: String = ""
  var clip: String = ""
  var genres = [String]()
  var publishers = [String]()
  var developers = [String]()
  var platforms = [UIImage]()
}

struct Screenshots: Identifiable, Hashable {
  var id: Int = 0
  var images = ""
}
