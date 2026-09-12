//
//  CameraConnectionState.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

enum CameraConnectionState: Equatable {
  case idle
  case connecting
  case streaming(cameraConnection: CameraConnection)
  case failed(error: CameraConnectionError)
}
