//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by valters.steinblums on 26/08/2022.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import Lottie

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    var cityName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeatherData(url: weatherDataModel.apiURL, params: ["appid": weatherDataModel.apiID, "q": cityName])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("long: \(location.coordinate.longitude) lat: \(location.coordinate.latitude)")
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            
            var params = [String: String]()
            if cityName == "" {
                params = ["lat": lat, "lon": long, "appid": weatherDataModel.apiID]
                getWeatherData(url: weatherDataModel.apiURL, params: params)
            } else {
                params = ["appid": weatherDataModel.apiID, "q": cityName]
            }
            
        }
    }
    
    func getWeatherData(url: String, params: [String: String]) {
        AF.request(url, method: .get, parameters: params).responseData { response in
            if response.value != nil {
                let weatherJSON: JSON = JSON(response.value!)
                self.updateWeatherData(json: weatherJSON)
                print(weatherJSON)
            } else {
                self.cityLabel.text = "Weather unavailable 😭"
            }
        }
    }
    
    func updateWeatherData(json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            weatherDataModel.temp = Int(tempResult - 273.14)
            weatherDataModel.name = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.wheaterIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUI()
        } else {
            self.cityLabel.text = "Weather unavailable 😭"
        }
    }
    
    func updateUI() {
        cityLabel.text = weatherDataModel.name
        temperatureLabel.text = "\(weatherDataModel.temp)°C"
        weatherIcon.image = UIImage(named: weatherDataModel.wheaterIconName)
    }
    
    // rewind segue
    @IBAction func getUserCity(_ sender: UIStoryboardSegue) {}
    
}
