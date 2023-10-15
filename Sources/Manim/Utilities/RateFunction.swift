//
//  RateFunction.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import Foundation


/// A selection of rate functions, i.e., speed curves for animations.
public enum RateFunction: String {
    
    case easeIn = "ease_in_sine"
    case easeOut = "ease_out_sine"
    case easeInOut = "ease_in_out_sine"
    case spring = "exponential_decay"
    case linear = "linear"
    
}
