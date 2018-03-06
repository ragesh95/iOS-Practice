//
//  Datas.swift
//  RakPractice
//
//  Created by shaik aqib on 06/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import Foundation
import UIKit

class Datas : NSObject, NSCoding {
    
    var name: String
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("datas")
    
    struct PropertyKey {
        static let name = "name"
    }
    
    init(name: String!) {
        self.name = name
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        self.init(name: name)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    static func saveDatas(datas: Datas, view: UIViewController) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(datas, toFile: Datas.ArchiveURL.path)
        if isSuccessfulSave {} else {
            ViewController.showToast(message: "Failed", view: view)
        }
    }
    
    static func loadDatas() -> Datas?{
        let datas = NSKeyedUnarchiver.unarchiveObject(withFile: Datas.ArchiveURL.path)
        return datas as? Datas
    }
    
}
