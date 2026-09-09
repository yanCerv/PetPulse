//
//  CameraOutputSpy.swift
//  PetPulseTests
//
//  Created by Codex on 09/09/26.
//

@testable import PetPulse

final class CameraOutputSpy: CameraOutput {

  private(set) var dismissCallCount = 0

  func dismiss() {
    dismissCallCount += 1
  }
}
