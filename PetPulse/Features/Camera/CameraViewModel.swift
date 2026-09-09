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
  private(set) var message: String = ""
  
  var showAlert: Bool = false
  
  //MARK: Init
  
  init(output: CameraOutput, client: any CameraProvider = CameraClient()) {
    self.output = output
    self.client = client
  }
  
  //MARK: Methods
  
  func connectCamera() async {
    connectionState = .connecting
    
    do {
      let cameraConnection = try await client.connect()
      connectionState = .streaming(cameraName: cameraConnection.cameraName)
    } catch {
      showAlert = true
      message = error.localizedDescription
      connectionState = .failed(message: error.localizedDescription)
    }
  }
  
  func dismissView() {
    output?.dismiss()
  }
}
