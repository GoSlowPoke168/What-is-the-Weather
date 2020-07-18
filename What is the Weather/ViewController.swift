//
//  ViewController.swift
//  What is the Weather
//
//  Created by Jeremy on 7/17/20.
//  Copyright © 2020 Jeremy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var outputLabel: UILabel!
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(textField.text!.replacingOccurrences(of: " ", with: "%20"))&appid=7ba1c689565875c7fe33589666bf7afc") {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print("Error")
                    } else {
                        if let urlContent = data {
                            do {
                                let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                print(jsonResult)
                                if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                                    DispatchQueue.main.sync(execute: {
                                    self.outputLabel.text = description
                                })
                            }
                        } catch {
                            print("JSON processing failed")
                        }
                    }
                    
                }
            }
            task.resume()
        } else {
            textField.text = "Couldn't find weather in that city. Please try again"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
