//
//  AccelerometerModelProtocol.swift
//  Paces
//
//  Created by Valentina Vențel on 03/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class AccelerometerModelProtocol: NSObject {
    func insertAccelerometerResults(result: Accelerometer) {
        let urlPath = "http://172.20.10.8/AccelerometerResults.php"
        
        guard let url = URL(string: urlPath) else {
            print("--------------------------Invalid URL", urlPath)
            return
        }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        
        let postString = "item1=\(result.x)&item2=\(result.y)&item3=\(result.z)"
        
        //Tets
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request) { data, response, error in
            
                            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                                print("error")
                                return
                            }
            
                            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            print("--------insert----------")
                            print(dataString)
                            print("------------------------")
                    }
            
            
                    task.resume()
    }
}
