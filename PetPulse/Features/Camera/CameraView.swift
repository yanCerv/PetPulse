//
//  CameraView.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import SwiftUI

struct CameraView: View {
  
  @State private var viewModel: CameraViewModel
  
  init(viewModel: CameraViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("PetPulse")
          .foregroundStyle(.white.opacity(0.8))
        Spacer()
        Button("", systemImage: "xmark.circle.fill") {
          viewModel.dismissView()
        }
      }
      .padding()
      
      Spacer()
      switch viewModel.connectionState {
      case .idle, .connecting, .failed(_):
        EmptyView()
      case .streaming(let cameraName):
        Text("Connected to: \(cameraName)")
          .foregroundStyle(.white.opacity(0.8))
          .accessibilityLabel("Live camera stream placeholder")
      }
      Spacer()
    }
    .task {
      await viewModel.connectCamera()
    }
    .overlay {
      if case .connecting = viewModel.connectionState {
        ProgressLoader(title: "Connecting to camera", description: "Checking your local network…")
      }
    }
    .background(.black)
    .alert("", isPresented: $viewModel.showAlert) {
      Button(connectionError.buttonTitle) {
        Task {
          await viewModel.didTapAlertButton()
        }
      }
    } message: {
      Text(connectionError.message)
    }
  }
  
  private var connectionError: CameraConnectionError {
    guard case let .failed(error) = viewModel.connectionState else { return .localNetworkUnavailable }
    return error
  }
}
