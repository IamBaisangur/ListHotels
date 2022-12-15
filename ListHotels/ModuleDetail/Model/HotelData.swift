//
//  HotelData.swift
//  ListHotels
//
//  Created by Байсангур on 23.11.2022.
//

import Foundation

struct HotelData: Decodable {
    let id: Int?
    let name: String?
    let address: String?
    let stars: Double?
    let distance: Double?
    let image: String?
    let suitesAvailability: String?
    let lat: Double?
    let lon: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance, image
        case suitesAvailability = "suites_availability"
        case lat, lon
    }
}
