//
//  CameraViewModel.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import SwiftUI

@Observable
final class CameraViewModel {
  
  private weak var output: CameraOutput?
  private let client: any CameraProvider
  private(set) var connectionState: CameraConnectionState = .idle
    
  var showAlert: Bool = false
  
  //MARK: Init
  
  init(output: CameraOutput, client: any CameraProvider = CameraClient()) {
    self.output = output
    self.client = client
  }
  
  //MARK: Methods
  
  func didTapAlertButton() async {
    guard case let .failed(error) = connectionState else { return }
    
    if error.shouldRetry {
      await connectCamera()
    } else {
      dismissView()
    }
  }
  
  func connectCamera() async {
    connectionState = .connecting
    
    do {
      let cameraConnection = try await client.connect()
      connectionState = .streaming(cameraName: cameraConnection.cameraName)
    } catch {
      let error = handleError(error: error)
      showAlert = true
      connectionState = .failed(error: error)
    }
  }
  
  func dismissView() {
    output?.dismiss()
  }
  
  func handleError(error: Error) -> CameraConnectionError {
    if let error  = error as? CameraConnectionError {
      return error
    }
    return .unknownError
  }
}
