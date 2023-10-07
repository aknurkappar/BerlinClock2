//
//  ViewController.swift
//  BerlinClock2
//
//  Created by коня on 30.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondsFigure: UIView!
    
    @IBOutlet weak var fiveHoursFigure: UIStackView!
    @IBOutlet weak var oneHourFigure: UIStackView!
    
    @IBOutlet weak var fiveMinutesFigure: UIStackView!
    @IBOutlet weak var oneMinuteFigure: UIStackView!
    
    @IBOutlet weak var timePicker: UIPickerView!
    
    var seconds : Int = 0
    var minutes : Int = 0
    var hours : Int = 0
    var timer : Timer = Timer()
    
    let hoursArray = Array(0...23)
    let minutesArray = Array(0...59)
    let secondsArray = Array(0...59)
    
    let calendar = Calendar.current
    let currentTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.delegate = self
        timePicker.dataSource = self
        
        startClock()
        getCurrentTime()
    }
    
    private func getCurrentTime(){
        let calendar = Calendar.current
        let currentTime = Date()
        let hoursAndMinutes = calendar.dateComponents([.hour, .minute, .second], from: currentTime)
        hours = hoursAndMinutes.hour!
        minutes = hoursAndMinutes.minute!
        seconds = hoursAndMinutes.second!
        selectRows()

    }
    
    private func selectRows(){
        timePicker.selectRow(hours, inComponent: 0, animated: true)
        timePicker.selectRow(minutes, inComponent: 1, animated: true)
        timePicker.selectRow(seconds, inComponent: 2, animated: true)
    }
    
    func startClock(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor), userInfo: nil, repeats: true)
    }
    
    func clock(){
        seconds = seconds + 1

        if seconds >= 60{
            seconds = 0
            minutes = minutes + 1
        }

        if minutes >= 60{
            minutes = 0
            hours = hours + 1
        }
    }
    
    @objc private func changeColor() -> Void {
        clock()
        
        if seconds%2 == 0{
            secondsFigure.backgroundColor = .orange
        } else {
            secondsFigure.backgroundColor = .darkGray
        }
        
        for index in fiveHoursFigure.arrangedSubviews.indices {
            if hours/5 > index {
                changeColorToOrange(fiveHoursFigure.arrangedSubviews[index])
            } else {
                changeColorToGray(fiveHoursFigure.arrangedSubviews[index])
            }
        }
        
        for index in oneHourFigure.arrangedSubviews.indices {
            if hours%5 > index {
                changeColorToOrange(oneHourFigure.arrangedSubviews[index])
            } else {
                changeColorToGray(oneHourFigure.arrangedSubviews[index])
            }
        }
        
        for index in fiveMinutesFigure.arrangedSubviews.indices {
            if minutes/5 > index && (index+1)%3 == 0{
                changeColorToRed(fiveMinutesFigure.arrangedSubviews[index])
            } else if minutes/5 > index {
                changeColorToOrange(fiveMinutesFigure.arrangedSubviews[index])
            } else {
                changeColorToGray(fiveMinutesFigure.arrangedSubviews[index])
            }
        }
        
        for index in oneMinuteFigure.arrangedSubviews.indices {
            if minutes%5 > index {
                changeColorToOrange(oneMinuteFigure.arrangedSubviews[index])
            } else {
                changeColorToGray(oneMinuteFigure.arrangedSubviews[index])
            }
        }
    }
    
    private func changeColorToOrange(_ element : UIView){
        element.backgroundColor = .orange
    }
    private func changeColorToRed(_ element : UIView){
        element.backgroundColor = .red
    }
    private func changeColorToGray(_ element : UIView){
        element.backgroundColor = .darkGray
    }
    
}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
         case 0:
             return hoursArray.count
         case 1:
             return minutesArray.count
         case 2:
             return secondsArray.count
         default:
             return 0
         }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
         case 0:
             return String(hoursArray[row])
         case 1:
             return String(minutesArray[row])
         case 2:
             return String(secondsArray[row])
         default:
             return nil
         }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
         case 0:
            hours = hoursArray[row]
         case 1:
            minutes = minutesArray[row]
         case 2:
            seconds = secondsArray[row]
         default:
             break
         }
    }
    
}
