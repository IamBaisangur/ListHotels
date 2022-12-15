//
//  Hotel.swift
//  ListHotels
//
//  Created by Байсангур on 23.11.2022.
//

import Foundation

struct Hotel: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suitesAvailability: Int
    
}

extension Hotel {
    init(getHotel: GetHotel) {
        
        func customSeparated(string: String) -> Int {
            let result: Int
            let characters = Array(string)
            let charactersCount = Array(string).count
            let elementsCountn = string.components(separatedBy: ":").count
            
            if characters[charactersCount - 1] != ":" {
                result = elementsCountn
            } else {
                result = elementsCountn - 1
            }
            return result
        }
        
        id = getHotel.id
        name = getHotel.name
        address = getHotel.address
        stars = getHotel.stars
        distance = getHotel.distance
        suitesAvailability = customSeparated(string: getHotel.suitesAvailability)
    }
}
