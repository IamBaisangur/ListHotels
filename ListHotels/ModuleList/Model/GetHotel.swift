//
//  GetHotel.swift
//  ListHotels
//
//  Created by Байсангур on 09.12.2022.
//

import Foundation

struct GetHotel: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suitesAvailability: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }
}
