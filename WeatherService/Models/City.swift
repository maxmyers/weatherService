//
//  City.swift
//  md4
//
//  Created by david Myers on 8/2/18.
//  Copyright © 2018 david Myers. All rights reserved.
// class func getWeather(_ zipCode:String,completion:@escaping (_ cities:[City]?)->()) -> (){
// city name, humidity, pressure, current temperature, and minimum and maximum temperature.
import UIKit
import Alamofire

class City: NSObject{
    var name:String?
    var id:String?
    var humidity:Double?
    var pressure:Double?
    var temperature:Double?
    var minTemperature:Double?
    var maxTemperature:Double?

    init(name:String?,humidity:Double?,pressure:Double?,temperature:Double?,minTemperature:Double?,maxTemperature:Double?,id:String?) {
        self.name = name
        self.humidity = humidity
        self.pressure = pressure
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.id = id
    }
    
}
    


