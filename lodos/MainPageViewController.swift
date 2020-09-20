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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.movieName.text = self.titleOfMovie
        cell.year.text = self.yearOfMovie
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 1 {
            self.searchText.placeholder = "Enter The Id Of Movie"
        } else {
            self.searchText.placeholder = "Enter The Title Of Movie"
        }
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        var parameters: [String : Any] = ["": (Any).self]
        let selectedItem = self.pickerView.selectedRow(inComponent: 0)
        if selectedItem == 0 {
            if (self.searchText.text != nil || self.searchText.text != "" && self.yearText.text == nil || self.yearText.text == "") {
                parameters = ["apiKey": "d110fc6", "t": self.searchText.text! as Any] as [String : Any]
            } else if (self.yearText.text != nil || self.yearText.text != "" && self.searchText.text != nil || self.searchText.text != "") {
                parameters = ["apiKey": "d110fc6", "t": self.searchText.text! as Any, "y" : self.yearText.text! as Any] as [String : Any]
            } else {
                parameters = ["apiKey": "d110fc6", "t": self.searchText.text! as Any] as [String : Any]
            }
        } else {
            if (self.searchText.text != nil || self.searchText.text != "" && self.yearText.text == nil || self.yearText.text == "") {
                parameters = ["apiKey": "d110fc6", "i": self.searchText.text! as Any] as [String : Any]
            } else if (self.yearText.text != nil || self.yearText.text != "" && self.searchText.text != nil || self.searchText.text != "") {
                parameters = ["apiKey": "d110fc6", "i": self.searchText.text! as Any, "y" : self.yearText.text! as Any] as [String : Any]
            } else {
                parameters = ["apiKey": "d110fc6", "i": self.searchText.text! as Any] as [String : Any]
            }
        }
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        print(parameters)
        AF.request("https://www.omdbapi.com", method: .post, parameters: parameters as Parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON {
            response in
            let screenWidth = self.screenSize.width
            let screenHeight = self.screenSize.height
            let spinner: SpinnerView = SpinnerView(frame: CGRect(x:screenWidth / 2 - 70, y: screenHeight / 2 - 20, width: 120, height: 120))
            self.view.addSubview(spinner)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print(response)
                switch response.result {
                case .success:
                    if let data = response.data {
                        print(data)
                        // Convert This in JSON
                        do {
                            let responseDecoded = try JSONDecoder().decode(ResponseModel.self, from: data)
                            print(responseDecoded)
                            self.yearOfMovie = responseDecoded.Year
                            self.titleOfMovie = responseDecoded.Title
                            self.movieTableView.reloadData()
                            self.movieTableView.isHidden = false
                            spinner.removeFromSuperview()
                        }catch let error as NSError{
                            print(error)
                            spinner.removeFromSuperview()
                            self.movieTableView.isHidden = true
                            let alert = UIAlertController(title: "Warning", message: "There is no movie with selected search criterias", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                (alert: UIAlertAction!) -> Void in
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                case .failure(let error):
                    print("Error:", error)
                }
            }
        }
    }
    var titleOfMovie = ""
    var yearOfMovie = ""
    let screenSize = UIScreen.main.bounds
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var movieTableView: UITableView!
    var movieList = ResponseModel(Title: "", Year: "", Rated: "", Released: "", Runtime: "", Genre: "", Director: "", Writer: "", Actors: "", Plot: "", Language: "", Country: "", Awards: "", Poster: "", Ratings: [["":""]], Metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", Type: "", DVD: "", BoxOffice: "", Production: "", Website: "", Response: "")
    var pickerData = ["By Title", "By Id"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        self.navigationItem.leftBarButtonItem = b
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
