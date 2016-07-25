//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    let numberOfComponents = 3
    let bigNumber = 31337
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fruitPicker.accessibilityLabel = Constants.FRUIT_PICKER
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        
        self.fruitPicker.dataSource = self
        self.fruitPicker.delegate = self
//        self.fruitPicker.userInteractionEnabled = false
        self.randomizeRows()
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.numberOfComponents
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bigNumber
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let element = row % fruitsArray.count
        return self.fruitsArray[element]
    }
    
    @IBAction func spinButtonTapped(sender: UIButton) {
        self.randomizeRows()
        
        if self.winner() {
            self.resultLabel.text = "WINNER!"
        } else {
            self.resultLabel.text = "TRY AGAIN"
        }
        
    }
    
    func randomizeRows() {
        var component = 0
        while component < numberOfComponents {
            let randomRow = Int(arc4random_uniform(UInt32(bigNumber - self.fruitsArray.count))) + self.fruitsArray.count
            fruitPicker.selectRow(randomRow, inComponent: component, animated: true)
            component += 1
        }
    }
    
    func winner() -> Bool {
        var component = 1
        let selectedRowIndex  = fruitPicker.selectedRowInComponent(0) % fruitsArray.count
        let firstComponentItem = self.fruitsArray[selectedRowIndex]
        
        while component < self.numberOfComponents {
            let nextSelectedRowIndex = self.fruitPicker.selectedRowInComponent(component) % fruitsArray.count
            let nextComponentItem = self.fruitsArray[nextSelectedRowIndex]
            if firstComponentItem != nextComponentItem {
                return false
            }
            component += 1
        }
        return true
    }
    
}





// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



