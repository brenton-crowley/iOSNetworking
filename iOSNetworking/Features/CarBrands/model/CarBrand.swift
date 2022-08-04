//
//  CarBrand.swift
//  iOSNetworking
//
//  Created by Brent on 4/8/2022.
//

import Foundation

struct CarBrand: Identifiable, Decodable {
    
    var uuid, rank, logoLink, origin, name, segment: String
    var id: String { uuid }
    
}

extension CarBrand {
    
    static var example:CarBrand {
        CarBrand.list.first!
    }
    
    static var list:[CarBrand] {
        
        [
            CarBrand(
                uuid: UUID().uuidString,
                rank: "1",
                logoLink: "https://learnrest.test/api/v1/datasets/car_logos/mg-logo.png",
                origin: "United Kingdom",
                name: "MG",
                segment: "Small Cars"),
            CarBrand(
                uuid: UUID().uuidString,
                rank: "2",
                logoLink: "https://learnrest.test/api/v1/datasets/car_logos/mg-logo.png",
                origin: "France",
                name: "Citroen",
                segment: "Mass-market Cars"),
            CarBrand(
                uuid: UUID().uuidString,
                rank: "3",
                logoLink: "https://learnrest.test/api/v1/datasets/car_logos/mg-logo.png",
                origin: "United States",
                name: "Hudson",
                segment: "Economy Cars"),
        ]
        
    }
    
}
