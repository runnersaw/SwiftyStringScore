//
//  ViewController.swift
//  StringScoreDemo
//
//  Created by YICHI ZHANG on 21/02/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
	
	@IBOutlet weak var sourceTextView: UITextView!
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var fuzzinessSlider: UISlider!
	@IBOutlet weak var resultLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		searchTextField.text = "Alice 😄 😅 "
	
		sourceTextView.text = "Alice has a Dingo. 😄 😅 😆 Alice lives in Wonderland."
		sourceTextView.delegate = self
		
		searchTextField.addTarget(self, action: "controlValueChanged:", forControlEvents: UIControlEvents.EditingChanged)
		fuzzinessSlider.addTarget(self, action: "controlValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
		
		self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "backgroundTouched:"))
		
		updateStringScore()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Slider value changed
	func controlValueChanged(sender:AnyObject) {
		updateStringScore()
	}

	// MARK: Background touched
	func backgroundTouched(sender:AnyObject) {
		sourceTextView.resignFirstResponder()
		searchTextField.resignFirstResponder()
	}
	
	// MARK: Update
	func updateStringScore() {
		let sourceText = sourceTextView.text
		let searchText = searchTextField.text
		
		let score = sourceText.score(word: searchText, fuzziness: Double(fuzzinessSlider.value))
		resultLabel.text = NSString(format: "%.3f", score)
	}
	
	// MARK: UITextViewDelegate
	func textViewDidChange(textView: UITextView) {
		updateStringScore()
	}
}

