//
//  CameraView.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import AVKit
import SwiftUI

struct CameraView: View {
  
  @State private var viewModel: CameraViewModel
  @State private var player: AVPlayer?
  
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
        VideoPlayer(player: player)
        Text("Connected to: \(cameraName.cameraName)")
          .foregroundStyle(.white.opacity(0.8))
          .accessibilityLabel("Live camera stream placeholder")
      }
      Spacer()
    }
    .onChange(of: viewModel.connectionState) { _, connectionState in
      guard case let .streaming(cameraConnection) = connectionState else { return }
      player = AVPlayer(url: cameraConnection.streamURL)
      player?.play()
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
    .onDisappear {
      player?.pause()
      player = nil
    }
  }
  
  private var connectionError: CameraConnectionError {
    guard case let .failed(error) = viewModel.connectionState else { return .localNetworkUnavailable }
    return error
  }
}
