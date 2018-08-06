//
//  APIClass.swift
//  md4
//
//  Created by david Myers on 8/5/18.
//  Copyright © 2018 david Myers. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

enum CityError: Error {
    case ResponseError(String)
    case ParseError(String)
}


class APIClass: NSObject {
    
    static var baseUrl = "https://api.openweathermap.org/data/2.5"
    static var weatherUrl = baseUrl + "/weather"
    
    // Get Weather By City Name
    class func getWeather(cityName:String,completion:@escaping (_ city:City?,_ CityError:Error?)->()){
        guard let url = URL.init(string: weatherUrl)else{
            return
        }
        let parameters: Parameters = ["q": cityName,"APPID":"663d5c5f0fd44f1d46723061e497cfb3"]
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding:  URLEncoding(destination: .queryString), headers: nil).responseJSON{ (response) in
            let (city,cityErr) = APIClass.parseJson(response)
            completion(city,cityErr)
        }
    }

    // Get Weather By CLLocation
    class func getWeather(location:CLLocation?,completion:@escaping (_ city:City?,_ CityError:Error?)->()){
        guard let url = URL.init(string: weatherUrl),
            let latitude  = location?.coordinate.latitude,
            let longitude = location?.coordinate.longitude else{
                completion(nil, CityError.ResponseError("Error With Location"))
                return
        }
        let parameters: Parameters = ["lat": String(latitude),
                                      "lon": String(longitude),
                                      "APPID":"663d5c5f0fd44f1d46723061e497cfb3"]
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding:  URLEncoding(destination: .queryString), headers: nil).responseJSON{ (response) in
            let (city,cityErr) = APIClass.parseJson(response)
            completion(city,cityErr)
        }
    }
    
    // Get Weather By ZipCode
    class func getWeather(zipCode:String,completion:@escaping (_ city:City?,_ CityError:Error?)->()){
        guard let url = URL.init(string: weatherUrl)else{
            return
        }
        let parameters: Parameters = ["zip": zipCode,"APPID":"663d5c5f0fd44f1d46723061e497cfb3"]
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding:  URLEncoding(destination: .queryString), headers: nil).responseJSON{ (response) in
            let (city,cityErr) = APIClass.parseJson(response)
            completion(city,cityErr)
        }
    }
    
    // Get Weather For Multiple Cities
    class func getWeather(cities:[City],completion:@escaping (_ cities:[City]?,_ CityError:Error?)->()){
        let urlString = baseUrl + "/group"
        guard let url = URL.init(string: urlString)else{
            return
        }
        let cityIDs = cities.map{$0.id}.flatMap{$0}.joined(separator: ",")
        let parameters: Parameters = ["APPID":"663d5c5f0fd44f1d46723061e497cfb3","id":cityIDs]
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding:  URLEncoding(destination: .queryString), headers: nil).responseJSON{ (response) in
            guard let jsonResponse = response.result.value as? [String:Any],
                let weatherArray = jsonResponse["list"] as? [[String:Any]] else{
                    completion(nil, nil)
                    return
            }
            var updatedCities:[City] = [City]()
            for weather in weatherArray{
                if let main = weather["main"] as? [String:Any] {
                    let name        = weather["name"]  as? String
                    let id          = weather["id"]    as? Int
                    let humidity    = main["humidity"] as? Double
                    let minTemp     = main["temp_min"] as? Double
                    let maxTemp     = main["temp_max"] as? Double
                    let temperature = main["temp"]     as? Double
                    let pressure    = main["pressure"] as? Double
                    let city = City.init(name: name, humidity: humidity, pressure: pressure, temperature: temperature, minTemperature: minTemp, maxTemperature: maxTemp, id: String(describing: id))
                    updatedCities.append(city)
                }
            }
            completion(updatedCities, nil)
        }
    }
    
    // MARK: - JSON Parsing
    class func parseJson(_ data:DataResponse<Any>)->(City?,CityError?){
        guard let jsonResponse = data.result.value as? [String:Any],
              let main         = jsonResponse["main"] as? [String:Any] else{
                return(nil, CityError.ResponseError("Parse JSON Error"))
        }
        let id          = jsonResponse["id"]   as? Int
        let cityName    = jsonResponse["name"] as? String
        let humidity    = main["humidity"]     as? Double
        let minTemp     = main["temp_min"]     as? Double
        let maxTemp     = main["temp_max"]     as? Double
        let temperature = main["temp"]         as? Double
        let pressure    = main["pressure"]     as? Double
        let city = City.init(name: cityName, humidity: humidity, pressure: pressure, temperature: temperature, minTemperature: minTemp, maxTemperature: maxTemp, id: String(describing: id))
        return(city,nil)
    }
}
