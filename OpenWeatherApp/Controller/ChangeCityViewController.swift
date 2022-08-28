//
//  ChangeCityViewController.swift
//  OpenWeatherApp
//
//  Created by valters.steinblums on 27/08/2022.
//

import UIKit

class ChangeCityViewController: UIViewController {
    
    @IBOutlet weak var cityName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let homeVC = segue.destination as! WeatherViewController
        homeVC.cityName = cityName.text ?? "Ventspils"
        
    }
    

}
