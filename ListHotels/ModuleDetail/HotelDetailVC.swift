//
//  HotelDetailVC.swift
//  ListHotels
//
//  Created by Байсангур on 27.11.2022.
//

import Foundation
import UIKit
import SnapKit

final class HotelDetailVC: UIViewController {
    let spinner = UIActivityIndicatorView(style: .gray)
    
    let name = UILabel()
    let address = UILabel()
    let stars = UILabel()
    let distance = UILabel()
    let suitesAvailability = UILabel()
    let lat = UILabel()
    let lon = UILabel()
    let backButton = UIButton()
    
    var hotel: Hotel?
    var hotelData: HotelData?
    
    let imageIV = CustomImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSpinner()
        view.backgroundColor = .lightGray
        if let hotel = hotel {
            getHotelData(idHotel: hotel.id)
        }
        setupImageConstraints()
        setupDetailDataConstraints()
        setupBackButton()
    }
    
    private func addSpinner() {
        view.addSubview(spinner)
        
        spinner.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        spinner.startAnimating()
    }
    
    private func removeSpinner() {
        DispatchQueue.main.sync {
            spinner.removeFromSuperview()
        }
    }
    
    private func multiplication<T> (value: T, _ count: Int) -> String {
        var string = ""
        for _ in 0..<count {
            string += "\(value)"
        }
        return string
    }
    
    private func customSeparated(string: String) -> Int {
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
    
    private func getDistance(distance: Double?) -> String {
        guard let newDistance = distance else {
            return "не указано сколько"
        }
        return String(newDistance)
    }
    
    private func getPosition(position: Double?) -> String {
        guard let newPosition = position else {
            return "не указано"
        }
        return String(newPosition)
    }

// MARK: - setupData()
    
    private func setupData() {
        DispatchQueue.main.sync {
            name.text = hotelData?.name
            address.text = hotelData?.address
            stars.text = multiplication(value: "⭐", Int(hotelData?.stars ?? 0))
            distance.text = "До центра \(getDistance(distance: hotelData?.distance)) м."
            suitesAvailability.text = "Свободных номеров: \(customSeparated(string: hotelData?.suitesAvailability ?? "0"))"
            lat.text = "Широта: \(getPosition(position: hotelData?.lat))"
            lon.text = "Долгота: \(getPosition(position: hotelData?.lon))"
        }
    }
    
    private func setupImageData(imageHotel: String) {
        if
            let url = URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(imageHotel)") {
            imageIV.loadImage(from: url)
            removeSpinner()
        }
    }
    
    private func getHotelData(idHotel: Int) {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(String(idHotel)).json") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, resp, error in
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                let currentHotelData = try JSONDecoder().decode(HotelData.self, from: data)
                self.hotelData = currentHotelData
                self.setupData()
                self.setupImageData(imageHotel: currentHotelData.image ?? "")
            } catch let error as NSError {
                print(error.localizedDescription)
            }

        }
        task.resume()
    }
    
    @objc private func backAction() {
        self.dismiss(animated: true)
    }
    
// MARK: - setupConstraints()
    
    private func setupImageConstraints() {
        view.addSubview(imageIV)
        imageIV.contentMode = .scaleAspectFit
        
        imageIV.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
    }
    
    private func setupDetailDataConstraints() {
        view.addSubview(name)
        view.addSubview(address)
        view.addSubview(stars)
        view.addSubview(distance)
        view.addSubview(suitesAvailability)
        view.addSubview(lat)
        view.addSubview(lon)
        
        name.font = UIFont(name: "Verdana-Bold", size: 16)
        name.lineBreakMode = .byTruncatingTail
        name.numberOfLines = 2
        
        name.snp.makeConstraints { make in
            make.top.equalTo(imageIV.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        address.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stars.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        distance.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(65)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        suitesAvailability.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(85)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        lat.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(110)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        lon.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(130)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = .gray
        backButton.layer.cornerRadius = 10
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
}
