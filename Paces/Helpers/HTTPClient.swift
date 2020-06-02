//
//  HTTPClient.swift
//  Paces
//
//  Created by Valentina Vențel on 08/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class HTTPClient: NSObject {
    class func getRunner(userName: String, date: Date, completionHandler: @escaping (_ result: NSArray, _ error: Error?)->()) {
        let urlPath = "http://127.0.0.1/selectRunner.php"
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: .default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Data task error:" + error.localizedDescription)
            } else if let data = data {
                print("Data downloaded successfully!")
                var jsonResult: NSArray = []
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                } catch let error as NSError {
                    print(error)
                }
                completionHandler(jsonResult, error)
            }
        }
        task.resume()
    }
}
