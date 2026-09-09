//
//  CameraConnectionError.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import Foundation

enum CameraConnectionError: LocalizedError {
  case cameraNotFound
  case invalidCredentials
  case localNetworkUnavailable
}
