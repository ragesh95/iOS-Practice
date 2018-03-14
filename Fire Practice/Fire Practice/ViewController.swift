//
//  ViewController.swift
//  Fire Practice
//
//  Created by shaik aqib on 06/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var logButton: UIButton!
    var ref: DatabaseReference!
    static var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        logButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func login() {
        guard let username: String = userText.text else {
            ViewController.showToast(message: "Invalid username", view: self)
            return
        }
        guard let password: String = passText.text else {
            ViewController.showToast(message: "Invalid password", view: self)
            return
        }
        ref.child("users").child(password).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let token = value?[username] as? String ?? ""
            if token == "" {
                print("Invalid username and password");
            }
            else {
                ViewController.token = token
                let storyboard = UIStoryboard(name: "Try", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "try")
                self.present(controller, animated: true, completion: nil)
                //self.dismiss(animated: true, completion: nil)
                print(token);
            }
        }) {(error) in
            print(error.localizedDescription)
        }
        
    }

    static func showToast(message : String?, view: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: view.view.frame.size.width/2 - 75, y: view.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

