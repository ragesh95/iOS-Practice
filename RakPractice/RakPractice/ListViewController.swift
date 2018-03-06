//
//  ListControllerViewController.swift
//  RakPractice
//
//  Created by shaik aqib on 05/03/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var numText: UITextField!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var outLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        getButton.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func getInfo() {
        let num = numText.text
        guard let nums = num else {return}
        let url = "http://numbersapi.com/\(nums)";
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
        let data = data.replacingOccurrences(of: ".", with: "\n")
        outLable.text = data
    }

}
