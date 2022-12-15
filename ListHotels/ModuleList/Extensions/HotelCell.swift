//
//  EmployeeCell.swift
//  ListHotels
//
//  Created by Байсангур on 23.11.2022.
//

import Foundation
import UIKit
import SnapKit

final class HotelCell: UITableViewCell {
    var safeArea: UILayoutGuide!
    let name = UILabel()
    let stars = UILabel()
    let distance = UILabel()
    let suitesAvailability = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightGray
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        safeArea = layoutMarginsGuide
        setupConstraints()
    }

// MARK: - setupConstraints()
    
    func setupConstraints() {
        
        safeArea.snp.makeConstraints { make in
            make.height.equalTo(103)
        }
        
        setupName()
        setupStars()
        setupDistance()
        setupSuitesAvailability()

    }

    func setupName() {
        addSubview(name)
        name.font = UIFont(name: "Verdana-Bold", size: 16)
        name.lineBreakMode = .byTruncatingTail
        name.numberOfLines = 2

        name.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.safeArea).inset(8)
        }
    }
    
    func setupStars() {
        addSubview(stars)
        stars.font = UIFont(name: "Verdana", size: 12)
        
        stars.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.safeArea).inset(68)
        }
    }
    
    func setupDistance() {
        addSubview(distance)
        distance.font = UIFont(name: "Verdana", size: 12)
        
        distance.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(self.safeArea).inset(68)
        }
    }
    
    func setupSuitesAvailability() {
        addSubview(suitesAvailability)
        suitesAvailability.font = UIFont(name: "Verdana", size: 12)
        
        suitesAvailability.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(self.safeArea).inset(88)
        }
    }
}
