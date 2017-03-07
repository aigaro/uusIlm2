//
//  XML.swift
//  uusIlm
//
//  Created by Aigar on 22/02/17.
//  Copyright © 2017 Aigar. All rights reserved.
//

import UIKit

struct WeatherData {
    
    var weatherDict: [String] = ["null", "üks", "kaks", "kolm", "neli", "viis", "kuus", "seitse", "kaheksa", "üheksa", "kümme", "üksteist", "kaksteist", "kolmteist", "neliteist", "viisteist", "kuusteist", "seitseteist", "kaheksateist", "üheksateist", "kakskümmend", "kakskümmend üks", "kakskümmend kaks", "kakskümmend kolm", "kakskümmend neli", "kakskümmend viis", "kakskümmend kuus", "kakskümmend seitse", "kakskümmend kaheksa", "kakskümmend üheksa", "kolmkümmend"]
    var tempMinDay = Int()
    var tempMaxDay = Int()
    var weatherTextDay = String()
    var arrayMin = [Int]()
    var arrayMax = [Int]()
    
    var tempMinNight = Int()
    var tempMaxNight = Int()
    var weatherTextNight = String()
    
    
    var weatherDate = [String]()
    var chosenDate = [String]()
    
    
    
}

