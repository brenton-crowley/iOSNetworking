//
//  StatusCode.swift
//  iOSNetworking
//
//  Created by Brent on 3/8/2022.
//

import Foundation


enum StatusCodeFilter: Int, CaseIterable {
    
    case one = 1, two, three, four, five
    
    var range: ClosedRange<Int> {
        
        switch self {
        case .one:
            return 0...3
        case .two:
            return 0...26
        case .three:
            return 0...8
        case .four:
            return 0...51
        case .five:
            return 0...11
        }
        
    }
    
    var label: String { "\(self.rawValue)xx" }
    
    
}

// MARK: Create the model struct of status and message.
// Use a static dictionary to store the messages
// - Status code
// - Message
