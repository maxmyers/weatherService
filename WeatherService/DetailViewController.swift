//
//  DetailViewController.swift
//  WeatherService
//
//  Created by david Myers on 8/6/18.
//  Copyright © 2018 Max Myers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var city:City?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateUI(city)
    }
    
    public func updateUI(_ newCity:City?){
        city = newCity
        if let name = newCity?.name{
            cityNameLabel.text = name
        }
        if let temp = newCity?.temperature{
            let tempString = convertToFahrenheit(kelvin: temp)
            cityNameLabel.text?.append(": \(tempString)")
            temperatureLabel.text = tempString
        }
        if let lowTemp = newCity?.minTemperature{
            let lowTempString = convertToFahrenheit(kelvin: lowTemp)
            lowTemperatureLabel.text = "Low: \(lowTempString)"
        }
        if let maxTemp = newCity?.maxTemperature{
            let maxTempString = convertToFahrenheit(kelvin: maxTemp)
            highTemperatureLabel.text = "High: \(maxTempString)"
        }
        if let humidity = newCity?.humidity{
            humidityLabel.text = "Humidity: \(Int(humidity)) %"
        }
        if let pressure = newCity?.pressure{
            pressureLabel.text = "Pressure: \(Int(pressure)) hpa"
        }
    }
}
