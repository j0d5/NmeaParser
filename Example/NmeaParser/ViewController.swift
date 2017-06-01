//
//  ViewController.swift
//  NmeaParser
//
//  Created by tweetjay on 05/31/2017.
//  Copyright (c) 2017 johannes82. All rights reserved.
//

import UIKit
import NmeaParser

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(NmeaParser.parseSentence(data: "$GPRMC,031849.49,A,5209.028,N,00955.836,E,,,310517,,E*7D"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

