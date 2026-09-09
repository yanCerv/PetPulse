//
//  CameraClient.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import Foundation

protocol CameraProvider: Sendable {
  func connect()  async throws -> CameraConnection
  func disconnect() async throws
}

actor CameraClient: CameraProvider {
  
  func connect() async throws -> CameraConnection {
    try await Task.sleep(nanoseconds: 1000_000_000)
    
    return CameraConnection(cameraName: "Tapo C210", streamURL: URL(string: "https://example.com/stream.m3u8")!)
  }
  
  func disconnect() async throws {
    try await Task.sleep(nanoseconds: 1000_000_000)
  }
}
