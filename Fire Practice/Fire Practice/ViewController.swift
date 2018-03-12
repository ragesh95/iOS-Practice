//
//  ViewController.swift
//  Fire Practice
//
//  Created by shaik aqib on 06/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var tokenButton: UIButton!
    @IBOutlet weak var outLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenButton.addTarget(self, action: #selector(handleLogTokenTouch), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogTokenTouch(_ sender: UIButton) {
        let token = Messaging.messaging().fcmToken
        printt(data: "FCM token: \(token ?? "")")
    }
    
    @IBAction func handleSubscribeTouch(_ sender: UIButton) {
        Messaging.messaging().subscribe(toTopic: "news")
        printt(data: "Subscribed to news topic")
    }
    
    func printt(data: String) {
        outLabel.text = data
    }


}

