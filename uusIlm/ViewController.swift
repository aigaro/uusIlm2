//
//  ViewController.swift
//  uusIlm
//
//  Created by Aigar on 22/02/17.
//  Copyright © 2017 Aigar. All rights reserved.
//
import UIKit
import Alamofire
import SWXMLHash

var weather = WeatherData()
var date = 0




class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherData()
        date1Button.layer.backgroundColor = UIColor.lightGray.cgColor
        windRange.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var dayTemp: UILabel!
    @IBOutlet weak var nightTemp: UILabel!
    @IBOutlet weak var dayText: UILabel!
    @IBOutlet weak var nightText: UILabel!
    @IBOutlet weak var descriptionDay: UILabel!
    @IBOutlet weak var descriptionNight: UILabel!
    @IBOutlet weak var windRange: UILabel!
    @IBOutlet weak var date1Button: UIButton!
    @IBOutlet weak var date2Button: UIButton!
    @IBOutlet weak var date3Button: UIButton!
    @IBOutlet weak var date4Button: UIButton!
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            date = 0
            reset_bg_color()
            //button?.layer.borderColor = UIColor.lightGray.cgColor
            date1Button.layer.backgroundColor = UIColor.lightGray.cgColor
            windRange.isHidden = false
        case 1:
            date = 1
            reset_bg_color()
            date2Button.layer.backgroundColor = UIColor.lightGray.cgColor
            windRange.isHidden = true
        case 2:
            date = 2
            reset_bg_color()
            date3Button.layer.backgroundColor = UIColor.lightGray.cgColor
            windRange.isHidden = true
        case 3:
            date = 3
            reset_bg_color()
            date4Button.layer.backgroundColor = UIColor.lightGray.cgColor
            windRange.isHidden = true
        default:
            return
        }
        weatherData()
    }
    
    func reset_bg_color() {
        for button_bg in [date1Button, date2Button, date3Button, date4Button] {
            button_bg?.layer.backgroundColor = nil
        }
    }
    
    func weatherData() {
        
        Alamofire.request("https://www.ilmateenistus.ee/ilma_andmed/xml/forecast.php").responseString { response in
            let xmltest = SWXMLHash.parse(response.data!)
            
            
            guard abs(weather.tempMinDay) < 41 && abs(weather.tempMaxDay) < 41 && abs(weather.tempMinNight) < 41 && abs(weather.tempMaxNight) < 41 else {return}
            
            weather.tempMinDay = Int(xmltest["forecasts"]["forecast"][date]["day"]["tempmin"].element!.text!)!
            weather.tempMaxDay = Int(xmltest["forecasts"]["forecast"][date]["day"]["tempmax"].element!.text!)!
            weather.weatherTextDay = xmltest["forecasts"]["forecast"][date]["day"]["text"].element!.text!
            
            weather.tempMinNight = Int(xmltest["forecasts"]["forecast"][date]["night"]["tempmin"].element!.text!)!
            weather.tempMaxNight = Int(xmltest["forecasts"]["forecast"][date]["night"]["tempmax"].element!.text!)!
            weather.weatherTextNight = xmltest["forecasts"]["forecast"][date]["night"]["text"].element!.text!
            
            for i in 0...3 {
                weather.chosenDate.append(xmltest["forecasts"]["forecast"][i].element!.attribute(by: "date")!.text)
            }
            
            self.date1Button.setTitle(weather.chosenDate[0], for: .normal)
            self.date2Button.setTitle(weather.chosenDate[1], for: .normal)
            self.date3Button.setTitle(weather.chosenDate[2], for: .normal)
            self.date4Button.setTitle(weather.chosenDate[3], for: .normal)
            
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {weather.arrayMin.append(Int( elem["speedmin"].element!.text! )!) }
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {weather.arrayMax.append(Int(elem["speedmax"].element!.text! )!) }
            
            self.windRange.text = "Tuule kiirus tänasel päeval on \(weather.arrayMin.max()!) kuni \(weather.arrayMax.max()!) m/s"
            
            switch Int(weather.tempMaxDay) {
            case -100 ... -1:
                self.dayText.text = "Päeval on külma miinus \(weather.weatherDict[weather.tempMinDay*(-1)]) kuni \(weather.weatherDict[weather.tempMaxDay*(-1)]) kraadi"
                self.dayTemp.text = "Päeval külma \(weather.tempMinDay) kuni \(weather.tempMaxDay) °C"
            case 0:
                self.dayText.text = "Päeval on külma miinus \(weather.weatherDict[weather.tempMinDay*(-1)]) kuni \(weather.weatherDict[weather.tempMaxDay]) kraadi"
                self.dayTemp.text = "Päeval on külma \(weather.tempMinDay) kuni \(weather.tempMaxDay) °C"
            case 1...100:
                switch Int(weather.tempMinDay) {
                case -100..<0:
                    self.dayText.text = "Päeval on külma miinus \(weather.weatherDict[abs(weather.tempMinDay)]) kuni pluss \(weather.weatherDict[weather.tempMaxDay]) kraadi"
                    self.dayTemp.text = "Päeval on külma \(weather.tempMinDay) kuni \(weather.tempMaxDay) °C"
                case 0...100:
                    self.dayText.text = "Päeval on sooja \(weather.weatherDict[abs(weather.tempMinDay)]) kuni \(weather.weatherDict[weather.tempMaxDay]) kraadi"
                    self.dayTemp.text = "Päeval on sooja \(weather.tempMinDay) kuni \(weather.tempMaxDay) °C"
                default:
                    return
                }
            default:
                return
            }
            
            switch Int(weather.tempMaxNight) {
            case -100 ... -1:
                self.nightText.text = "Öösel on külma miinus \(weather.weatherDict[weather.tempMinNight*(-1)]) kuni \(weather.weatherDict[weather.tempMaxNight*(-1)]) kraadi"
                self.nightTemp.text = "Öösel on külma \(weather.tempMinNight) kuni \(weather.tempMaxNight) °C"
            case 0:
                self.nightText.text = "Öösel on külma miinus \(weather.weatherDict[weather.tempMinNight*(-1)]) kuni \(weather.weatherDict[weather.tempMaxNight]) kraadi"
                self.nightTemp.text = "Öösel on külma \(weather.tempMinNight) kuni \(weather.tempMaxNight) °C"
            case 1...100:
                switch Int(weather.tempMinNight) {
                case -100..<0:
                    self.nightText.text = "Öösel on külma miinus \(weather.weatherDict[abs(weather.tempMinNight)]) kuni pluss \(weather.weatherDict[weather.tempMaxNight]) kraadi"
                    self.nightTemp.text = "Öösel on külma \(weather.tempMinNight) kuni \(weather.tempMaxNight) °C"
                case 0...100:
                    self.nightText.text = "Öösel on sooja \(weather.weatherDict[weather.tempMinNight]) kuni \(weather.weatherDict[weather.tempMaxNight]) kraadi"
                    self.nightTemp.text = "Öösel on sooja \(weather.tempMinNight) kuni \(weather.tempMaxNight) °C"
                default:
                    return
                }
            default:
                return
            }
            
            self.descriptionDay.text = "Päev. \(weather.weatherTextDay)"
            self.descriptionNight.text = "Öö. \(weather.weatherTextNight)"
        }
        
        for button in [date1Button, date2Button, date3Button, date4Button] {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        for layer in [dayTemp, nightTemp, dayText, nightText, descriptionDay, descriptionNight, windRange] {
            layer?.layer.borderWidth = 1
            
        }
        
        
    }
    
    
    
}
