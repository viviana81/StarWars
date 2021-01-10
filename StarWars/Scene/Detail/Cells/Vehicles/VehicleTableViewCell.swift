//
//  VehicleTableViewCell.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import UIKit

class VehicleTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var manifacturerLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(withVehicle vehicle: Vehicle) {
        nameLabel.text = vehicle.name
        modelLabel.text = vehicle.model
        manifacturerLabel.text = vehicle.manufacturer
        lenghtLabel.text = vehicle.lenght
        priceLabel.text = vehicle.price
    }
}
