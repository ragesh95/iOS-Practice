//
//  ViewController.swift
//  BMI Calculator
//
//  Created by shaik aqib on 12/03/18.
//  Copyright © 2018 Rageshwaran. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var outText: UITextView!
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UDID \(UIDevice.current.identifierForVendor!.uuidString)")
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-4071831192467764/7780820042"
        bannerView.rootViewController = self
        addBannerViewToView(bannerView)
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func calculate() {
        outText.isHidden = false
        guard let height: String = heightText.text else {
            outText.text = "Invalid Height"
            return
        }
        guard let weight: String = weightText.text else {
            outText.text = "Invalid Weight"
            return
        }
        let kg: Float = NSString(string: weight).floatValue
        let m: Float = NSString(string: height).floatValue / 100
        let bmi: Float = kg / (m * m)
        if bmi < 18 {
            outText.text = "Please increase your weight\n\nBMI: \(bmi)"
        } else if bmi < 24 {
            outText.text = "Congrats! Maintain the same level. Your weight is normal\n\nBMI: \(bmi)"
        } else {
            outText.text = "Please decrease your weight\n\nBMI: \(bmi)"
        }
    }


}

