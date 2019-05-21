//
//  AppUI.swift
//  Earnest
//
//  Created by Novare Account on 26/02/2019.
//  Copyright © 2019 Bon Ryan Santiano. All rights reserved.
//

import UIKit

public enum AppUI {
    
    public enum Color {
        
        static let baliHaiBlue: UIColor = UIColor(red: 0.51, green: 0.6, blue: 0.63, alpha: 1)
        static let blue: UIColor = UIColor(red: 106.0/255.0, green: 184.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        static let caribbeanGreen: UIColor = UIColor(red: 0.03, green: 0.75, blue: 0.63, alpha: 1)
        static let dark: UIColor = UIColor(red: 89.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 1.0)
        static let gray: UIColor = UIColor(red: 130.0/255.0, green: 154.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        static let green: UIColor = UIColor(red: 7.0/255.0, green: 192.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        static let heatherBlue: UIColor = UIColor(red: 0.7, green: 0.78, blue: 0.8, alpha: 1)
        static let lightGray: UIColor = UIColor(red: 239.0/255.0, green: 243.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        static let mediumBlue: UIColor =  UIColor(red: 0.17, green: 0, blue: 0.88, alpha: 1)
        static let purpleBlue: UIColor = UIColor(red: 44.0/255.0, green: 0.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        static let red: UIColor = UIColor(red: 233.0/255.0, green: 0.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    }
    
    public enum Theme {
        
        static let primaryColor: UIColor = AppUI.Color.caribbeanGreen
        static let secondaryColor: UIColor = AppUI.Color.mediumBlue
        
        static let bottomBorderColor: UIColor = UIColor.black
        static let buttonColor: UIColor = AppUI.Color.baliHaiBlue
        static let componentAccessoryColor: UIColor = AppUI.Color.heatherBlue
        static let errorColor: UIColor = AppUI.Color.red
        static let textDefaultColor: UIColor = UIColor.black
        // TODO: Add other component colors
        // link color
        // agreement text color
    }
}
