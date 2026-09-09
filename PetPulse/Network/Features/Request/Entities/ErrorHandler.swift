//
//  ErrorHandler.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import Foundation

enum ErrorHandler<T: Decodable>: Error {
  case requestFail
  case jsonConversionFail
  case error(data: ErrorData)
}

struct ErrorData: Decodable {
  let message: String
  let status: Int
}
