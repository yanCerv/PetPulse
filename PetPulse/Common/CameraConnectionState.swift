//
//  CameraConnectionState.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

enum CameraConnectionState: Equatable {
  case idle
  case connecting
  case streaming(cameraName: String)
  case failed(message: String)
}
