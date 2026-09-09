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

  private let responses: [Response]

  private var responseIndex = 0

  private(set) var connectCallCount = 0

  init(response: Response) {
    self.responses = [response]
  }

  init(responses: [Response]) {
    precondition(!responses.isEmpty)
    self.responses = responses
  }

  func connect() async throws -> CameraConnection {
    connectCallCount += 1
    let response = responses[min(responseIndex, responses.count - 1)]
    responseIndex += 1

    switch response {
    case .success(let connection):
      return connection
    case .failure(let error):
      throw error
    }
  }

  func disconnect() async throws {}
}
