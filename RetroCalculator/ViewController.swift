//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Abdul-Mujib Aliu on 4/23/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    var runningNumberVal: String!
    var leftHandVal: String!
    var rightHandVal: String!
    var resultVal: String!

    var currentOperation = Operation.Empty
    
    //OUTLETS THEM
    @IBOutlet weak var calcLabel: UILabel!
    
    //ACTION FIR THEM ALL NUMS
    @IBAction func numberBtnPressed(_ sender: UIButton) {
        playSound()
        
        runningNumberVal = runningNumberVal + "\(sender.tag)"
        calcLabel.text = runningNumberVal
    }
    
    
    enum Operation: String {
        case Divide = "/"
        case Mutiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let uri = URL(fileURLWithPath: path!)
        
        calcLabel.text = ""
        runningNumberVal = ""
        leftHandVal = ""
        rightHandVal = ""
        resultVal = ""

        
        do{
            try btnSound = AVAudioPlayer(contentsOf: uri)
            btnSound.prepareToPlay()
            
        }catch let error as NSError{
            print(error.description)
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func processOperation(operation: Operation) {
        if(currentOperation != Operation.Empty){
            
            if(runningNumberVal != ""){
                rightHandVal = runningNumberVal
                runningNumberVal = ""
                
                if(operation == Operation.Mutiply){
                    resultVal  = "\(Double(leftHandVal)! * Double(rightHandVal)!)"
                }else if(operation == Operation.Divide){
                    resultVal  = "\(Double(leftHandVal)! / Double(rightHandVal)!)"
                }else if(operation == Operation.Add){
                    resultVal  = "\(Double(leftHandVal)! + Double(rightHandVal)!)"
                }else if(operation == Operation.Subtract){
                    resultVal  = "\(Double(leftHandVal)! - Double(rightHandVal)!)"
                }
                
                leftHandVal = resultVal
                calcLabel.text = resultVal
                
            }
            currentOperation = operation
        }else{
        
            leftHandVal = runningNumberVal
            runningNumberVal = ""
            currentOperation = operation
        }
    }
    
    
    @IBAction func mutliplyBtnPressed(_ sender: UIButton) {
        processOperation(operation: .Mutiply)
    }
    
    @IBAction func divideBtnPressed(_ sender: UIButton) {
        processOperation(operation: .Divide)

    }

    @IBAction func addBtnPressed(_ sender: UIButton) {
        processOperation(operation: .Add)

    }

    @IBAction func subtractBtnPressed(_ sender: UIButton) {
        processOperation(operation: .Subtract)

    }

    @IBAction func equalBtnPressed(_ sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clearBtnPressed(_ sender: UIButton) {
        leftHandVal = "1"
        rightHandVal = "1"
        runningNumberVal = ""
        resultVal = ""
        calcLabel.text = ""
        currentOperation = .Empty
    }
    
    
    func playSound() {
        if(btnSound.isPlaying){
            btnSound.stop()
        }
        
        btnSound.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

