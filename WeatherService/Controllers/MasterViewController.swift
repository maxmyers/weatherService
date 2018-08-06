//
//  MasterViewController.swift
//  TakeHome1
//
//  Created by david Myers on 8/5/18.
//  Copyright © 2018 Max Myers. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    var cities:[City] = [City]()
    var selectedCity:City?
    var weatherForCitiesLoaded = false
    
    // MARK: - ViewDidLoad | Appear
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDefaultCities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIClass.getWeather(cities: cities) { (cityArray, err) in
            guard let cityArrayUnwrapped = cityArray else{
                return
            }
            self.cities = cityArrayUnwrapped
            self.tableView.reloadData()
            self.weatherForCitiesLoaded = true
        }
    }
    
    // MARK: - Add Default Cities
    private func setUpDefaultCities(){
        let losAngeles = City.init(name: "Los Angeles", humidity: nil, pressure: nil, temperature: nil, minTemperature: nil, maxTemperature: nil, id: "5368361")
        let lasVegas = City.init(name: "Las Vegas", humidity: nil, pressure: nil, temperature: nil, minTemperature: nil, maxTemperature: nil, id: "5506956")
        let nyc = City.init(name: "New York", humidity: nil, pressure: nil, temperature: nil, minTemperature: nil, maxTemperature: nil, id: "5128581")
        let miami = City.init(name: "Miami", humidity: nil, pressure: nil, temperature: nil, minTemperature: nil, maxTemperature: nil, id: "4164138")
        let reno = City.init(name: "Reno", humidity: nil, pressure: nil, temperature: nil, minTemperature: nil, maxTemperature: nil, id: "5511077")
        cities = [lasVegas,reno,losAngeles,nyc,miami]
    }
    
    // MARK: - UITableViewDataSource | Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        let city = cities[indexPath.row]
        cell.setUp(city)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let splitViewController  = self.splitViewController as? SplitViewController else{
            return
        }
        guard weatherForCitiesLoaded == true else{
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        selectedCity = cities[indexPath.row]
        if splitViewController.isCollapsed{
            tableView.deselectRow(at: indexPath, animated: false)
            performSegue(withIdentifier: "Detail", sender: self)
        }else{
            if let detailViewController = splitViewController.viewControllers[1] as? DetailViewController{
                detailViewController.updateUI(selectedCity)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController{
            detailViewController.city = selectedCity
        }
    }
}
