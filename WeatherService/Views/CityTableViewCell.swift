//
//  CityTableViewCell.swift
//  md4
//
//  Created by david Myers on 8/5/18.
//  Copyright © 2018 david Myers. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(_ city:City?){
        if let name = city?.name{
            nameLabel.text = name
        }
        if let temperature = city?.temperature{
            let fahrenheitString = convertToFahrenheit(kelvin: temperature)
            nameLabel.text?.append(": \(fahrenheitString)")
        }
    }
    
    func clearLabel(){
        textLabel?.text = ""
    }

}
