//
//  ViewController.swift
//  iOS Flash Cards
//
//  Created by Stephen Ciauri on 3/17/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet var circularButtons: [UIView]!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    private var timerRunning: Bool = false
    private var timer: NSTimer?
    private var timeLeft: Int?
    private var maxTime = 300
    private var seconds: Int{
        get{
            return timeLeft!/10
        }
    }
    private var milliseconds: Int{
        get{
            return timeLeft!%10
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLeft = maxTime
        
        nextButton.hidden = true
        topicLabel.hidden = true

        // Round corners
        _ = circularButtons.map({ view in
            view.layer.cornerRadius = view.frame.width/2
        })

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped(sender: UIButton) {
        timeLeft = maxTime
        updateLabelToNextTopic()
    }
    
    @IBAction func startStopButtonTapped(sender: UIButton){
        timerRunning = !timerRunning
        nextButton.hidden = !nextButton.hidden
        resetButton.hidden = !resetButton.hidden
        topicLabel.hidden = false

        sender.backgroundColor = timerRunning ? UIColor.redColor() : UIColor.greenColor()
        sender.setTitle(timerRunning ? "Stop" : "Start", forState: .Normal)
        
        if !timerRunning{
            timer?.invalidate()
        }else{
            timeLeft == maxTime ? updateLabelToNextTopic() : ()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimerLabel", userInfo: nil, repeats: true)
        }
        
        
    }
    
    @IBAction func resetButtonTapped(sender: UIButton){
        timeLeft = maxTime
        timerLabel.text = String(format: "%02d.%d", seconds, milliseconds)
        topicLabel.hidden = true
    }
    
    func updateTimerLabel(){
        if timeLeft! > 0{
            timeLeft! -= 1
        }else{
            timeLeft = maxTime
            updateLabelToNextTopic()
        }
        
        timerLabel.text = String(format: "%02d.%d", seconds, milliseconds)

        
    }
    
    func updateLabelToNextTopic(){
        let numberOfTopics = Constants.topics.count
        topicLabel.text = Constants.topics[Int(arc4random_uniform(UInt32(numberOfTopics)))]
    }

  


}
