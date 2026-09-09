//
//  CameraProviderMock.swift
//  PetPulseTests
//
//  Created by Codex on 09/09/26.
//

@testable import PetPulse

actor CameraProviderMock: CameraProvider {

  enum Response {
    case success(CameraConnection)
    case failure(any Error)
  }

  private let response: Response

  private(set) var connectCallCount = 0

  init(response: Response) {
    self.response = response
  }

  func connect() async throws -> CameraConnection {
    connectCallCount += 1

    switch response {
    case .success(let connection):
      return connection
    case .failure(let error):
      throw error
    }
  }

  func disconnect() async throws {}
}
