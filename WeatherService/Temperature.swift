//
//  Temperature.swift
//  md4
//
//  Created by david Myers on 8/5/18.
//  Copyright © 2018 david Myers. All rights reserved.
//

import Foundation

func convertToFahrenheit(kelvin kelvinTemp:Double)->String{
    var temperature = Measurement(value: kelvinTemp, unit: UnitTemperature.kelvin)
    temperature.convert(to: UnitTemperature.fahrenheit)
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .medium
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 0
    formatter.numberFormatter = numberFormatter
    return formatter.string(from:temperature)
}
