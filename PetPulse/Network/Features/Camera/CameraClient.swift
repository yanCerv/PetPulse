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
  
  private var connectionCounter = 0
  private var retry: Int = 1
  
    
  func connect() async throws -> CameraConnection {
    try await Task.sleep(nanoseconds: 2000_000_000)
    
    var cammeraConnection: CameraConnection?
    for _ in 0...retry {
      connectionCounter += 1
      if connectionCounter == retry {
        throw CameraConnectionError.unknownError
      } else {
        let url = URL(string: "https://example.com/stream.m3u8")!
        cammeraConnection = CameraConnection(cameraName: "Topo C210", streamURL: url)
      }
    }
    
    return cammeraConnection!
  }
  
  func disconnect() async throws {
    try await Task.sleep(nanoseconds: 1000_000_000)
  }
  
  //for test pruposes
  enum ConnectionType {
    case error
    case succes
  }
}
