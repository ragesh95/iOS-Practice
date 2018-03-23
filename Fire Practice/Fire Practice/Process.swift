//
//  Process.swift
//  Fire Practice
//
//  Created by shaik aqib on 13/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import Firebase
import AVFoundation

class Process {
    
    init(remoteMessage: MessagingRemoteMessage) {
        let type: String = "\(remoteMessage.appData["type"] as? String ?? "")";
        process(type: type)
    }
    
    func process(type: String) {
        print(type)
        if type == "playring" {
            playRing()
        }
        else if type == "checknetdelivered" {
            ViewController.showToast(message: "Internet Available", view: TryController.tryObj)
        }
        else if type == "playringdelivered" {
            ViewController.showToast(message: "Ringtone started playing", view: TryController.tryObj)
        }
        else if type == "stopplayringdelivered" {
            ViewController.showToast(message: "Ringtone stopped playing", view: TryController.tryObj)
        }
        else if type == "startvibratedelivered" {
            ViewController.showToast(message: "Vibrating", view: TryController.tryObj)
        }
        else if type == "stopvibratedelivered" {
            ViewController.showToast(message: "Vibration Stopped", view: TryController.tryObj)
        }
        else if type == "displayblankdelivered" {
            ViewController.showToast(message: "Displaying Blank Screen", view: TryController.tryObj)
        }
        else if type == "stopblankdelivered" {
            ViewController.showToast(message: "Displaying Blank Screen Stopped", view: TryController.tryObj)
        }
        else if type == "ringmodedelivered" {
            ViewController.showToast(message: "Turned on Ring Mode", view: TryController.tryObj)
        }
        else if type == "lockphonedelivered" {
            ViewController.showToast(message: "Locked Phone", view: TryController.tryObj)
        }
    }
    
    func playRing() {
        let systemSoundID: SystemSoundID = 1003
        AudioServicesPlaySystemSound (systemSoundID)
        var bombSoundEffect: AVAudioPlayer?
        let path = Bundle.main.path(forResource: "iphone.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.prepareToPlay()
            let x = bombSoundEffect?.play()
            print("Playing Sound \(path) \(x)")
        } catch {
            print("File not found")
        }
        print("Playing Sound")
    }
    
}
