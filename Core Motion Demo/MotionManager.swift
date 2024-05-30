//
//  MotionManager.swift
//  Core Motion Demo
//
//  Created by Min Thu Khine on 5/30/24.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()
    
    @Published var isOnFlatSurface = true
    @Published var isAnswerKey = false
    @Published var isAnswerValue = false
      
      init() {
          motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
              guard let motion = motion, error == nil else { return }
              
              let pitch = abs(motion.attitude.pitch)
              let roll = abs(motion.attitude.roll)
             // let yaw = abs(motion.attitude.yaw)
              self?.isOnFlatSurface = pitch < 0.7
              
              self?.isAnswerKey = roll < 0.5
              self?.isAnswerValue = roll > 2.9
          }
      }
}
