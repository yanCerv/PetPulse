//
//  ProgressLoader.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import SwiftUI

struct ProgressLoader: View {
  
  var title: String
  var message: String
  
  init(title: String = "", description: String = "") {
    self.title = title
    self.message = description
  }
  
  var body: some View {
    VStack(spacing: 12) {
      ProgressView()
        .progressViewStyle(.circular)
        .tint(.white)
        .scaleEffect(1.15)
      
      if !title.isEmpty {
        Text(title)
          .font(.subheadline.weight(.medium))
          .foregroundStyle(.white)
          .multilineTextAlignment(.center)
        
      }
      if !message.isEmpty {
        Text(message)
          .font(.caption)
          .foregroundStyle(.white.opacity(0.55))
          .multilineTextAlignment(.center)
      }
    }
    .padding(.horizontal, 28)
    .padding(.vertical, 22)
    .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 20))
  }
}

