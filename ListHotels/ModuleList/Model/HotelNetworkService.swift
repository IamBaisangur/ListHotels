//
//  HotelNetworkService.swift
//  ListHotels
//
//  Created by Байсангур on 23.11.2022.
//

import Foundation
import UIKit

enum Errors:Error {
    case invalidURL
    case invalidState
}

final class HotelNetworkServiceInpl {
    
    func getHotels(completion: @escaping ([GetHotel]) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json") else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, resp, error in
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let currentHotels: [GetHotel] = try decoder.decode([GetHotel].self, from: data)
                completion(currentHotels)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
