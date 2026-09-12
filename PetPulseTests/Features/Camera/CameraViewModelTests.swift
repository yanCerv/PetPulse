//
//  CameraViewModelTests.swift
//  PetPulseTests
//
//  Created by Codex on 09/09/26.
//

import XCTest
@testable import PetPulse

@MainActor
final class CameraViewModelTests: XCTestCase {

  func test_init_shouldStartIdle() {
    // Given
    let client = CameraProviderMock(response: .success(makeCameraConnection()))
    let sut = makeSUT(client: client)

    // Then
    XCTAssertEqual(sut.connectionState, .idle)
  }

  func test_connectCamera_success_shouldShowStreamingAndCallClientOnce() async {
    // Given
    let cameraConnection = makeCameraConnection()
    let client = CameraProviderMock(response: .success(cameraConnection))
    let sut = makeSUT(client: client)

    // When
    await sut.connectCamera()

    // Then
    let connectCallCount = await client.connectCallCount
    XCTAssertEqual(sut.connectionState, .streaming(cameraConnection: cameraConnection))
    XCTAssertEqual(connectCallCount, 1)
  }

  func test_connectCamera_retryAfterFailure_shouldShowStreamingAndCallClientTwice() async {
    // Given
    let cameraConnection = makeCameraConnection()
    let client = CameraProviderMock(
      responses: [
        .failure(CameraConnectionError.cameraNotFound),
        .success(cameraConnection)
      ]
    )
    let sut = makeSUT(client: client)

    // When
    await sut.connectCamera()

    // Then
    let firstConnectCallCount = await client.connectCallCount
    XCTAssertEqual(
      sut.connectionState,
      .failed(error: .cameraNotFound)
    )
    XCTAssertEqual(firstConnectCallCount, 1)

    // When
    await sut.didTapAlertButton()

    // Then
    let secondConnectCallCount = await client.connectCallCount
    XCTAssertEqual(sut.connectionState, .streaming(cameraConnection: cameraConnection))
    XCTAssertEqual(secondConnectCallCount, 2)
  }

  func test_didTapAlertButton_nonRetryableFailure_shouldDismissAndNotReconnect() async {
    // Given
    let output = CameraOutputSpy()
    let client = CameraProviderMock(response: .failure(CameraConnectionError.localNetworkUnavailable))
    let sut = CameraViewModel(output: output, client: client)

    // When
    await sut.connectCamera()
    await sut.didTapAlertButton()

    // Then
    let connectCallCount = await client.connectCallCount
    XCTAssertEqual(sut.connectionState, .failed(error: .localNetworkUnavailable))
    XCTAssertEqual(connectCallCount, 1)
    XCTAssertEqual(output.dismissCallCount, 1)
  }

  private func makeSUT(client: any CameraProvider) -> CameraViewModel {
    CameraViewModel(output: CameraOutputSpy(), client: client)
  }

  private func makeCameraConnection() -> CameraConnection {
    CameraConnection(
      cameraName: "Living Room Tapo",
      streamURL: URL(string: "https://example.com/stream.m3u8")!
    )
  }
}
