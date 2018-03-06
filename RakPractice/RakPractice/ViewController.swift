//
//  ViewController.swift
//  RakPractice
//
//  Created by shaik aqib on 01/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var numOne: UITextField!
    @IBOutlet weak var numTwo: UITextField!
    @IBOutlet weak var numOut: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var mul: UIButton!
    @IBOutlet weak var div: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var numapiLabel: UILabel!
    weak var popup: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        sub.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        mul.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        div.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextController), for: .touchUpInside)
        let datas: Datas = Datas(name: "testname")
        Datas.saveDatas(datas: datas, view: self)
        guard let allDatas: Datas = Datas.loadDatas() else {
            return
        }
        ViewController.showToast(message: "\(allDatas.name)", view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonClicked(sender: UIButton) {
        let a: Int! = Int(numOne.text!)
        let b: Int! = Int(numTwo.text!)
        var c = 0
        if sender === add {
            c = a + b
            getInfo(x: c)
            numOut.text = "Add: \(c)"
        } else if sender === sub {
            c = a - b
            getInfo(x: c)
            numOut.text = "Sub: \(c)"
        } else if sender === mul {
            c = a * b
            getInfo(x: c)
            numOut.text = "Mul: \(c)"
        } else if sender === div {
            c = a / b
            getInfo(x: c)
            numOut.text = "Div: \(c)"
        } else {
            numOut.text = "Failed"
        }
    }
    
    @objc func getInfo(x: Int) {
        if isInternetAvailable() == false {
            return
        }
        let url = "http://numbersapi.com/\(x)";
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let urls = URL(string: url)!
        let x = self
        let task = session.dataTask(with: urls, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                x.printt(data: "nil1")
                guard let err = error else {
                    return
                }
                x.printt(data: err.localizedDescription)
                return
            }
            x.printt(data: String(data: data, encoding: String.Encoding.utf8) as String!)
        })
        task.resume()
    }
    
    @objc func printt(data: String) {
        numapiLabel.text = data
    }
    
    @objc func nextController() {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "list")
        self.present(controller, animated: true, completion: nil)
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
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }


}

