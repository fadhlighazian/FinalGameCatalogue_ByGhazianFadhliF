//
//  VideoPlayer.swift
//  FinalGameCatalogue_ByGhazianFadhliF
//
//  Created by Ghazian Fadhli Fakhrusy on 04/01/21.
//

import Foundation
import SwiftUI
import AVKit

//Component Video Player
struct Player: UIViewControllerRepresentable {
  
  @Binding var data: String
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<Player>) -> AVPlayerViewController {
    
    let controller = AVPlayerViewController()
    let player = AVPlayer(url: URL(string:data)!)
    controller.player = player
    return controller
  }
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<Player>) {
  }
}
