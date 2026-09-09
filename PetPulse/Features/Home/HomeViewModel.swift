//
//  HomeViewModel.swift
//  PetPulse
//
//  Created by Yan Cervantes  on 09/09/26.
//

import SwiftUI

@Observable
final class HomeViewModel {
  
  var showCamera: Bool = false
  
  //MARK: - Init
  
  init() {
    
  }
  
  //MARK: - Methods
  
  @MainActor
  func didTapShowCamera() {
    showCamera = true
  }
  
  //MARK: - Private Methods
}

//MARK: - Camera Outputs

extension HomeViewModel: CameraOutput {
  
  func dismiss() {
    showCamera = false
  }
}
