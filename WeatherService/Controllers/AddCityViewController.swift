//
//  AddLocationViewController.swift
//  md4
//
//  Created by david Myers on 8/5/18.
//  Copyright © 2018 david Myers. All rights reserved.
//

import UIKit
import CoreLocation

class AddCityViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
   
    var city:City?
    var location:Location?

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func currentLocationSelected(_ sender: UIButton) {
       location = Location()
       location?.findLocation({ (cityLocation, locationErr) in
            guard locationErr == nil else{
                self.present(self.createErrorAlert("Location Error"), animated: true, completion: nil)
                return
            }
            APIClass.getWeather(location: cityLocation, completion: { (foundCity, weatherErr) in
                guard weatherErr == nil else{
                    self.present(self.createErrorAlert("Weather Error"), animated: true, completion: nil)
                    return
                }
                self.city = foundCity
                self.tableView.reloadData()
            })
        })
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UISearchBarDelegate
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let zipCode = searchBar.text else{
            return
        }
        APIClass.getWeather(zipCode: zipCode) { (foundCity, err) in
            guard err == nil else{
                return
            }
            self.city = foundCity
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource | Delegate
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        cell.clearLabel()
        cell.setUp(city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let masterVC = self.navigationController?.viewControllers.first as? MasterViewController else{
            return
        }
        if let city = city{
             masterVC.cities.append(city)
             masterVC.tableView.reloadData()
             self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Helpers
    func createErrorAlert(_ text:String)->UIAlertController {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController{
            detailViewController.city = city
        }
    }
}
