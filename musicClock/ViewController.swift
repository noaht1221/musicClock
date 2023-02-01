//
//  ViewController.swift
//  musicClock
//
//  Created by Noah Thompson on 1/31/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var remainingLabel: UILabel!
    
    @IBOutlet weak var timeInput: UIDatePicker!
    
    @IBOutlet weak var startButton: UIButton!
    
   
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    var dateTimer: Timer = Timer()
    var speed : Float = 1.0
    var timeLeft : Int?
    var estimatedTime : Int?
    var countdownTimer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let format = DateFormatter()
                format.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
                dateLabel.text = format.string(from: Date())
                format.dateFormat = "a"
                format.string(from: Date()) == "AM" ? changeBackground("dayBg") :
                    changeBackground("nightBg")
        startButton.setTitle("Start Timer", for: .normal)
               startButton.configuration?.baseForegroundColor = UIColor.black

               timeInput.setValue(UIColor.white, forKeyPath: "textColor")
               
               remainingLabel.text = "Time Remaining:"
               
               getDateTime()
    }
    
    func changeBackground (_ imageName : String) {
        backgroundImage.image = UIImage(named: imageName)
    }

    private func getDateTime() {
            dateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.dateTime) , userInfo: nil, repeats: true)
        }
    @objc func dateTime() {
            let format = DateFormatter()
            format.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
            dateLabel.text = format.string(from: Date())

            format.dateFormat = "a"

            format.string(from: Date()) == "AM" ? changeBackground("dayBg") :
                changeBackground("nightBg")
        }
    func secondsConverter(_ seconds: Int) -> (Int, Int, Int) {
           return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
       }
    func printSecondsConverter(_ seconds: Int) -> String {
            let (h, m, s) = secondsConverter(seconds)
            return String(format: "%02d:%02d:%02d",h,m,s)
        }
    
    @IBAction func startCountdown(_ sender: Any) { countdownTimer.invalidate()
        if (startButton.currentTitle == "Start Timer") {
            startButton.setTitle("Stop Music", for: .normal)
            timeLeft = Int(timeInput.countDownDuration)
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(initiateCountDown), userInfo: nil, repeats: true)
            remainingLabel.text = "Time Remaining: \(printSecondsConverter(Int(timeInput.countDownDuration)))"
        } else {
            
            startButton.setTitle("Start Timer", for: .normal)
        }
    }
    
    @objc func initiateCountDown() {
           if timeLeft! >= 0 {
               remainingLabel.text = "Time Remaining: \(printSecondsConverter(timeLeft!))"
               timeLeft! -= 1
           } else {
               countdownTimer.invalidate()
               
           }
       }
    
}

