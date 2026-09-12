//
//  ContentView.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 08/09/26.
//

import SwiftUI

struct HomeView: View {
  
  @State private var viewModel: HomeViewModel = HomeViewModel()
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
        .padding()
      Spacer()
      Button("", systemImage: "camera.fill") {
        viewModel.didTapShowCamera()
      }
      .padding(.all, 26)
    }
    .sheet(isPresented: $viewModel.showCamera) {
      CameraView(viewModel: CameraViewModel(output: viewModel))
        .interactiveDismissDisabled(true)
    }
  }
}
