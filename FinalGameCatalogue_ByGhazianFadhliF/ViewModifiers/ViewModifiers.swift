//
//  ViewModifiers.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 07/01/21.
//

import Foundation
import SwiftUI


struct RatingStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.body)
      .foregroundColor(.white)
      .padding(.all, 10)
      .background(Color.black.opacity(0.7))
      .cornerRadius(20)
  }
}
