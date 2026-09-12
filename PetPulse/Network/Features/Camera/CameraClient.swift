//
//  CameraClient.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import Foundation

protocol CameraProvider {
  func connect()  async throws -> CameraConnection
  func disconnect() async throws
}

actor CameraClient: CameraProvider {
  
  private let streamURL: URL?
  
  init() {
    let streamURL = ProcessInfo.processInfo.environment["PETPULSE_HLS_URL"]
    self.streamURL = streamURL.flatMap(URL.init(string:))
  }
    
  func connect() async throws -> CameraConnection {
    guard let streamURL else {
      throw CameraConnectionError.unknownError
    }
    
    return CameraConnection(cameraName: "Tapo C200", streamURL: streamURL)
  }
  
  func disconnect() async throws {
    
  }
  
  //for test pruposes
  enum ConnectionType {
    case error
    case succes
  }
}
