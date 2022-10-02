//
//  TwitterCharactersCounterViewController.swift
//  Twitter-Counter
//
//  Created by Yousef Elsayed on 02/10/2022.
//

import UIKit
import TWTextEditor

class TwitterCharactersCounterViewController: UIViewController {

    @IBOutlet weak var typedCharactersLabel: CounterLabel!
    @IBOutlet weak var remainingCharactersLabel: CounterLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        typedCharactersLabel.text = "0/280"
        remainingCharactersLabel.text = "280"

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


}

