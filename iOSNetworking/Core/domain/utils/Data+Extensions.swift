//
//  Data+Extensions.swift
//  iOSNetworking
//
//  Created by Brent on 11/8/2022.
//

import Foundation

extension Data {
    
    func isJSON() -> Bool {

        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let _ = String(data: data, encoding: .utf8) else {
                print("Inavlid data")
                return false
            }
            return true
        } catch {
            print("Error: \(error.localizedDescription). The data probably isn't JSON.")
        }
        
        return false
    }
    
    func printJson() {
        
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Inavlid data")
                return
            }
            print(jsonString)
        } catch {
            if let string = String(data: self, encoding: .utf8) { print(string) }
            print("Error: \(error.localizedDescription). The data probably isn't JSON.")
        }
    }
}

extension Data {
    
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) { self.append(data) }
    }
    
}
