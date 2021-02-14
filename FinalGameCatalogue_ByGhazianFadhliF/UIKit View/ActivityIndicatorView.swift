//
//  ActivityIndicatorView.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 02/01/21.
//

import SwiftUI

struct Indicator: UIViewRepresentable {
  
  func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
    
    let indi = UIActivityIndicatorView(style: .large)
    indi.color = UIColor.gray
    return indi
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
    uiView.startAnimating()
  }
}
