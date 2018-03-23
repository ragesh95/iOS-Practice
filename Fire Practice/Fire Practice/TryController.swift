//
//  TryController.swift
//  Fire Practice
//
//  Created by shaik aqib on 13/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class TryController: UIViewController {

    @IBOutlet weak var netButton: UIButton!
    
    @IBOutlet weak var playringButton: UIButton!
    @IBOutlet weak var stopringButton: UIButton!
    
    @IBOutlet weak var startvibButton: UIButton!
    @IBOutlet weak var stopvibButton: UIButton!
    
    @IBOutlet weak var blankButton: UIButton!
    @IBOutlet weak var stopblankButton: UIButton!
    
    @IBOutlet weak var ringButton: UIButton!
    
    @IBOutlet weak var lockButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    static var tryObj: TryController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TryController.tryObj = self
        progressView.isHidden = true
        netButton.addTarget(self, action: #selector(checkNet), for: .touchUpInside)
        
        playringButton.addTarget(self, action: #selector(playRing), for: .touchUpInside)
        stopringButton.addTarget(self, action: #selector(stopRing), for: .touchUpInside)
        
        blankButton.addTarget(self, action: #selector(self.common), for: .touchUpInside)
        stopblankButton.addTarget(self, action: #selector(self.common), for: .touchUpInside)
        
        startvibButton.addTarget(self, action: #selector(self.common), for: .touchUpInside)
        stopvibButton.addTarget(self, action: #selector(self.common), for: .touchUpInside)
        
        ringButton.addTarget(self, action: #selector(self.common), for: .touchUpInside)
        
        lockButton.addTarget(self, action: #selector(self.common), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func checkNet() {
        if progressView.isHidden == true {
            progressView.isHidden = false
            let data = [
                "type": "checknet",
                "token": InstanceID.instanceID().token() ?? ""
            ]
            let token = ViewController.token
            progressView.setProgress(0.5, animated: true)
            send(token: token, data: data)
        }
        else {
            ViewController.showToast(message: "Wait until old Progress finishes", view: self)
            return
        }
    }
    
    @objc func playRing() {
        if progressView.isHidden == true {
            progressView.isHidden = false
            let data = [
                "type": "playring",
                "token": InstanceID.instanceID().token() ?? ""
            ]
            let token = ViewController.token
            progressView.setProgress(0.5, animated: true)
            send(token: token, data: data)
        }
        else {
            ViewController.showToast(message: "Wait until old Progress finishes", view: self)
            return
        }
    }
    
    @objc func stopRing() {
        if progressView.isHidden == true {
            progressView.isHidden = false
            let data = [
                "type": "stopplayring",
                "token": InstanceID.instanceID().token() ?? ""
            ]
            let token = ViewController.token
            progressView.setProgress(0.5, animated: true)
            send(token: token, data: data)
        }
        else {
            ViewController.showToast(message: "Wait until old Progress finishes", view: self)
            return
        }
    }
    
    @objc func common(sender: UIButton) {
        if progressView.isHidden == true {
            progressView.isHidden = false
            let data = [
                "type": getType(sender: sender),
                "token": InstanceID.instanceID().token() ?? ""
            ]
            let token = ViewController.token
            progressView.setProgress(0.5, animated: true)
            send(token: token, data: data)
        }
        else {
            ViewController.showToast(message: "Wait until old Progress finishes", view: self)
            return
        }
    }
    
    func getType(sender: UIButton) -> String {
        if sender == netButton {
            return "checknet"
        }
        else if sender == playringButton {
            return "playring"
        }
        else if sender == stopringButton {
            return "stopplayring"
        }
        else if sender == blankButton {
            return "displayblank"
        }
        else if sender == stopblankButton {
            return "stopblank"
        }
        else if sender == startvibButton {
            return "startvibrate"
        }
        else if sender == stopvibButton {
            return "stopvibrate"
        }
        else if sender == ringButton {
            return "ringmode"
        }
        else if sender == lockButton {
            return "lockphone"
        }
        else {
            return ""
        }
    }
    
    func send(token: String, data: Any) {
        let data: [String: Any] = [
            "to": token,
            "priority": "high",
            "data": data
        ]
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "key=AAAAGMlgyzA:APA91bEbaUHxov-DtMSY43SSqMB-aiOXD85EcYN1B7nY8A_NojQndFyvF-oCXpblS95Ucb6xJ5XC3Y__sEALuhSq5pBE0ZkLaWEO1d2UzUqzfl4Yse0TLYxDEdCV0PrkF8dgsyw9IuG-"
        ]
        //let data2 = "{\"to\": \(token), \"priority\": \"high\", \"data\": \(data)}"
        let url: URLConvertible = "https://fcm.googleapis.com/fcm/send"
        let method: HTTPMethod = HTTPMethod.post
        let encoding: ParameterEncoding = JSONEncoding.default
        let s = self
        progressView.setProgress(0.7, animated: true)
        Alamofire.request(url,
                          method: method,
                          parameters: data,
                          encoding: encoding,
                          headers:headers)
            .validate()
            .responseJSON { response in
                if response != nil{
                    s.progressView.setProgress(0.9, animated: true)
                    s.progressView.isHidden = true
                    print("success")
                    print(response)
                } else{
                    s.progressView.setProgress(0.9, animated: true)
                    s.progressView.isHidden = true
                    print("error")
                }
        }
    }

}
