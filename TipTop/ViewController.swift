//
//  ViewController.swift
//  TipTop
//
//  Created by Joey Steigelman on 6/14/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardsCollection: [UIView]!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipStepper: UIStepper!
    @IBOutlet weak var splitTipLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var verticalSpacerView: UIView!
    @IBOutlet weak var horizontalSpacerView: UIView!
    @IBOutlet var textCollection: [UILabel]!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        verticalSpacerView.isHidden = true
        horizontalSpacerView.isHidden = true
        configureCards()
        configureText()
        
        //Check for taps
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureCards() {
        for card in cardsCollection {
            card.layer.cornerRadius = 14
        }
        
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 6
        calculateButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    func configureText() {
        for text in textCollection {
            text.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)

        }
        

    }

    @IBAction func calculateTip() {
        //get bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        //get total tip by multiplying tip * tipPercentage
        let tipPercentage = Double(tipPercentLabel.text!) ?? 18.00
        let tip = (tipPercentage/100) * bill
        let total = bill + tip
        
        //display payment values
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalAmountLabel.text = String(format: "$%.2f", total)
        
        //update split
        let split = Double(splitNumberLabel.text!) ?? 1
        if split > 1 {
            let totalSplit = total / split
            let tipSplit = tip / split
            splitTipLabel.text = String(format: "$%.2f", tipSplit)
            splitTotalLabel.text = String(format: "$%.2f", totalSplit)
        } else if split == 1 {
            splitTipLabel.text = "-"
            splitTotalLabel.text = "-"

        }

    }
    
    @IBAction func tipStepperDidChange(_ sender: UIStepper) {
        tipPercentLabel.text = Int(sender.value).description
        
        calculateTip()
    }
    
    @IBAction func splitStepperDidChange(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
        calculateTip()
    }
    
    
    @IBAction func billAmountButtonOnClick(_ sender: Any) {
        calculateTip()
    }
    
    //Dismiss Numpad when tap outside of numpad
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
}

