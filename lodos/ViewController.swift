//
//  ViewController.swift
//  lodos
//
//  Created by Efe Mazlumoğlu on 19.09.2020.
//  Copyright © 2020 Efe Mazlumoğlu. All rights reserved.
//

import UIKit
import Network
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
    }
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.label.text = "Internet connected"
                    self.label.textColor = UIColor.white
                    self.view.backgroundColor = .systemGreen
                    self.setupRemoteConfigDefaults()
                    self.fetchRemoteConfig()
                    self.displayNewValues()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "mainPage") as! MainPageViewController
                        let navEditorViewController: UINavigationController = UINavigationController(rootViewController: vc)
                        navEditorViewController.modalPresentationStyle = .fullScreen
                        self.present(navEditorViewController, animated: true, completion: nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.label.text = "There is no internet connection"
                    self.label.textColor = UIColor.white
                    self.view.backgroundColor = .systemRed
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    func setupRemoteConfigDefaults() {
        let defaultValue = ["label_text": "LODOS!" as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
    func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: 3, completionHandler: {
            (status, error) in
            guard error == nil else { return }
            print("Got the value from Remote Config!")
            remoteConfig.activate(completion: nil)
            self.displayNewValues()
        })
    }
    func displayNewValues() {
        let newLabelText = remoteConfig.configValue(forKey: "label_text").stringValue ?? ""
        self.label.text = newLabelText
    }
}

