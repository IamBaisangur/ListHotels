//
//  ViewController.swift
//  ListHotels
//
//  Created by Байсангур on 23.11.2022.
//

import UIKit
import SnapKit

final class ListHotelsVC: UIViewController {
    let spinner = UIActivityIndicatorView(style: .medium )
    
    let tableView = UITableView()
    let buttonSort = UIButton()
    var getHotels = [GetHotel]()
    var hotels = [Hotel]()
    var networkManagerGetHotels = HotelNetworkServiceInpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HotelCell.self, forCellReuseIdentifier: "cellid")
        setupView()
        addSpinner()
        
        let anonymFunction = { (getHotels: [GetHotel]) in
            DispatchQueue.main.async {
                let hotelForViewList = getHotels.map { hotel in
                    return GetHotel.init(id: hotel.id,
                                      name: hotel.name,
                                      address: hotel.address,
                                      stars: hotel.stars,
                                      distance: hotel.distance,
                                      suitesAvailability: hotel.suitesAvailability)
                }
                
                self.getHotels = hotelForViewList
                self.saveData()
                self.tableView.reloadData()
                self.removeSpinner()
            }
        }
        networkManagerGetHotels.getHotels(completion: anonymFunction)
    }
    
    private func saveData() {
        for hotel in getHotels {
            let newHotel = Hotel.init(getHotel: hotel)
            hotels.append(newHotel)
        }
    }
    
    private func addSpinner() {
        view.addSubview(spinner)
        
        spinner.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        spinner.startAnimating()
    }
    
    private func removeSpinner() {
        self.spinner.removeFromSuperview()
    }
    
    @objc private func openMenu() {
        let menuInteraction = UIContextMenuInteraction(delegate: self)
        buttonSort.addInteraction(menuInteraction)
    }
    
// MARK: - setupConstraints()

    private func setupView() {
        view.addSubview(buttonSort)
        view.addSubview(tableView)
        buttonSort.backgroundColor = .gray
        buttonSort.layer.cornerRadius = 10
        buttonSort.setTitle("Sort", for: .normal)
        tableView.backgroundColor = .lightGray
        
        buttonSort.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.centerX).offset(50)
            make.trailing.equalToSuperview().inset(20)
        }
        
        buttonSort.addTarget(self, action: #selector(openMenu), for: .touchUpInside)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonSort.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension ListHotelsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        guard let hotelCell = cell as? HotelCell else {
            return cell
        }
        
        let hotelName = hotels[indexPath.row].name
        hotelCell.name.text = hotelName
        
        let hotelStars = hotels[indexPath.row].stars
        hotelCell.stars.text = multiplication(value: "⭐", Int(hotelStars))
        
        let hotelDistance = hotels[indexPath.row].distance
        hotelCell.distance.text = "До центра \(String(hotelDistance)) м."
        
        let hotelSuitesAvailability = hotels[indexPath.row].suitesAvailability
        hotelCell.suitesAvailability.text = "Свободных номеров: \(hotelSuitesAvailability)"
        
        return cell
    }
    
    private func multiplication<T> (value: T, _ count: Int) -> String {
        var string = ""
        for _ in 0..<count {
            string += "\(value)"
        }
        return string
    }
}

// MARK: - UITableViewDelegate

extension ListHotelsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotel = self.hotels[indexPath.row]
        let hotelDetailVC = HotelDetailVC()
        hotelDetailVC.hotel = hotel
        self.present(hotelDetailVC, animated: true)
    }
}

// MARK: - UIContextMenuInteractionDelegate

extension ListHotelsVC: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                
                let distanceDown = UIAction(title: "меньше расстояние от центра", image: UIImage(systemName: "arrow.down")) { _ in
                    self.hotels = self.hotels.sorted(by: {$0.distance < $1.distance})
                    self.tableView.reloadData()
                }
                
                let suitesAvailabilityDown = UIAction(title: "меньше свободных номеров", image: UIImage(systemName: "arrow.down")) { _ in
                    self.hotels = self.hotels.sorted(by: {$0.suitesAvailability < $1.suitesAvailability})
                    self.tableView.reloadData()
                }
                
                let distanceUp = UIAction(title: "больше расстояние от центра", image: UIImage(systemName: "arrow.up")) { _ in
                    self.hotels = self.hotels.sorted(by: {$0.distance > $1.distance})
                    self.tableView.reloadData()
                }
                
                let suitesAvailabilityUp = UIAction(title: "больше свободных номеров", image: UIImage(systemName: "arrow.up")) { _ in
                    self.hotels = self.hotels.sorted(by: {$0.suitesAvailability > $1.suitesAvailability})
                    self.tableView.reloadData()
                }
                
                return UIMenu(title: "Сортировать:", children: [distanceDown, distanceUp, suitesAvailabilityDown, suitesAvailabilityUp])
            }
    }
}
