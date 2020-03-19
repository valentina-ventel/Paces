//
//  ViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 03/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var accelerometerXDirection: UITextField!
    @IBOutlet weak var accelerometerYDirection: UITextField!
    @IBOutlet weak var accelerometerZDirection: UITextField!
    @IBOutlet weak var giroscopeXDirection: UITextField!
    @IBOutlet weak var giroscopeYDirection: UITextField!
    @IBOutlet weak var giroscopeZDirection: UITextField!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
    
    var motion = CMMotionManager()
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //myAccelerometer()
        //myGyro()
        //startUpdating()
    }


    func myAccelerometer() {
                motion.accelerometerUpdateInterval = 2
        
                motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                    print(data as Any)
                    if let trueData = data {
                        self.view.reloadInputViews()
                        let x = trueData.acceleration.x
                        let y = trueData.acceleration.y
                        let z = trueData.acceleration.z
                        
                        print("x = \(x)")
                        print("y = \(y)")
                        print("z = \(z)")
                        self.accelerometerXDirection.text = "x: \(Double(x))"
                        self.accelerometerYDirection.text = "y: \(Double(y))"
                        self.accelerometerZDirection.text = "z: \(Double(z))"
                        
                        let acc = Accelerometer(x: x, y: y, z: z)
                        let httpRequest = AccelerometerModelProtocol()
                        httpRequest.insertAccelerometerResults(result: acc)
                    }
            }
        }
        
    func myGyro() {
        motion.gyroUpdateInterval = 2
        
        motion.startGyroUpdates(to: OperationQueue.main) { (data, error) in
            if let gyroData = data {
                self.view.reloadInputViews()
                let xGyro = gyroData.rotationRate.x
                let yGyro = gyroData.rotationRate.y
                let zGyro = gyroData.rotationRate.z
                
                self.giroscopeXDirection.text = "x: \(Double(xGyro))"
                self.giroscopeYDirection.text = "y: \(Double(yGyro))"
                self.giroscopeZDirection.text = "z: \(Double(zGyro))"
            }
        }
    }
    
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            
            guard let activity = activity else { return}
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityTypeLabel.text = "Walking"
                } else if activity.stationary {
                    self?.activityTypeLabel.text = "Stationary"
                } else if activity.running {
                    self?.activityTypeLabel.text = "Running"
                } else if activity.automotive {
                    self?.activityTypeLabel.text = "Automotive"
                }
            }
        }
    }
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return}
            
            DispatchQueue.main.async {
                self?.stepsCountLabel.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }
    
    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        }
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
    }
    
    
    
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let division = pow(10.0, Double(places))
        return(self*division).rounded() / division
    }
}

