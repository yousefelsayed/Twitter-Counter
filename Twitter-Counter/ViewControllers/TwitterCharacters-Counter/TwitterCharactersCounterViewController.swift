//
//  TwitterCharactersCounterViewController.swift
//  Twitter-Counter
//
//  Created by Yousef Elsayed on 02/10/2022.
//

import UIKit
import TWTextEditor

class TwitterCharactersCounterViewController: UIViewController {

    @IBOutlet weak var twTextView: TWTextEditorView!
    @IBOutlet weak var typedCharactersLabel: CounterLabel!
    @IBOutlet weak var clearTextButton: TWPrimaryButton!
    @IBOutlet weak var copyTextButton: TWPrimaryButton!
    @IBOutlet weak var postTweetButton: TWPrimaryButton!
    @IBOutlet weak var remainingCharactersLabel: CounterLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        twTextView.viewDelegate = self
        hideKeyboardWhenTappedAround()
        setupAccessabilityIdentifiers()
        self.twTextView.textView.becomeFirstResponder()
    }


    func setUpNavBar(){
        //For title in navigation bar
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.11, green: 0.129, blue: 0.122, alpha: 1)
        self.navigationItem.title = "Twitter character count"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.11, green: 0.129, blue: 0.122, alpha: 1),
                                                                        NSAttributedString.Key.font: UIFont.twFontMediumWithSize(size: 18)]
    }

    func setupAccessabilityIdentifiers() {
        self.twTextView.accessibilityIdentifier = "twTextView"
        self.twTextView.textView.accessibilityIdentifier = "myTextView"
        self.twTextView.textView.isAccessibilityElement = true
        self.typedCharactersLabel.accessibilityIdentifier = "typedCharactersLabel"
        self.remainingCharactersLabel.accessibilityIdentifier = "remainingCharactersLabel"
        self.clearTextButton.accessibilityIdentifier = "clearTextButton"
        self.copyTextButton.accessibilityIdentifier = "copyTextButton"
        self.postTweetButton.accessibilityIdentifier = "postTweetButton"
    }
    
    @IBAction func copyTextButtonAction(_ sender: Any) {
        self.twTextView.copyCurrentText()
    }
    
    @IBAction func clearTextButtonAction(_ sender: Any) {
        self.twTextView.clearText()
    }
    
}


extension TwitterCharactersCounterViewController: TWTextEditorViewDelegate {
  
    func textDidChange(_ textView: UITextView) {
        
        self.typedCharactersLabel.text = "\(self.twTextView.typedCharachtersCount ?? 0)/\(self.twTextView.maxCountOfCharchters)"
        self.remainingCharactersLabel.text = "\(self.twTextView.remainingCharachtersCount ?? 0)"
        
    }
}

