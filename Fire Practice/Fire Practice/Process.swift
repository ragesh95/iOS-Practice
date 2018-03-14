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
