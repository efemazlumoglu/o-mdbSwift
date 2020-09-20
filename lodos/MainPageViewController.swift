//
//  MainPageViewController.swift
//  lodos
//
//  Created by Efe Mazlumoğlu on 20.09.2020.
//  Copyright © 2020 Efe Mazlumoğlu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        let paramaters = ["apiKey": "d110fc6", "t": self.searchText.text! as Any] as [String : Any]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        print(paramaters)
        AF.request("https://www.omdbapi.com", method: .post, parameters: paramaters as Parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON {
                    response in
                    print(response)
            }
    }
    
    let screenSize = UIScreen.main.bounds
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var movieTableView: UITableView!
    var movieList = ResponseModel(Title: "", Year: "", Rated: "", Released: "", Runtime: "", Genre: "", Director: "", Writer: "", Actors: "", Plot: "", Language: "", Country: "", Awards: "", Poster: "", Ratings: RateModel(Source: "", Value: ""), Metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", Type: "", DVD: "", BoxOffice: "", Production: "", Website: "", Response: "")
    var pickerData = ["By Title", "By Id"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        self.navigationItem.leftBarButtonItem = b
//        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
//        let spinner: SpinnerView = SpinnerView(frame: CGRect(x:screenWidth / 2 - 70, y: screenHeight / 2 - 20, width: 120, height: 120))
//        self.view.addSubview(spinner)
        self.movieTableView.dataSource = self
        self.movieTableView.delegate = self
        self.movieTableView.isHidden = true
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    @objc func cancelClicked () {
        self.dismiss(animated: true, completion: nil)
    }
}
