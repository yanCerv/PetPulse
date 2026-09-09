//
//  CameraConnectionError.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import Foundation

enum CameraConnectionError: LocalizedError {
  case fail
  case cameraNotFound
  case invalidCredentials
  case localNetworkUnavailable
  case unknownError
  
  var message: String {
    switch self {
    case .fail:
      return "Something went wrong"
    case .cameraNotFound:
      return "Camera not found"
    case .invalidCredentials:
      return "Invalid credentials"
    case .localNetworkUnavailable:
      return "Local network unavailable"
    case .unknownError:
      return "Unknown error"
    }
  }
  
  var buttonTitle: String {
    switch self {
    case .fail, .cameraNotFound:
      return "Try again"
      
    case .unknownError, .localNetworkUnavailable, .invalidCredentials:
      return "Close"
    }
  }
  
  var shouldRetry: Bool {
    switch self {
    case .fail, .cameraNotFound:
      return true
      
    case .unknownError, .localNetworkUnavailable, .invalidCredentials:
      return false
    }
  }
}
