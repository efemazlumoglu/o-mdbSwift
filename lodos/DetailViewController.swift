//
//  DetailViewController.swift
//  lodos
//
//  Created by Efe Mazlumoğlu on 20.09.2020.
//  Copyright © 2020 Efe Mazlumoğlu. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleOfMovie: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var rated: UILabel!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var boxoffice: UILabel!
    var imageLink: String = ""
    var actorText: String = ""
    var runtimeText: String = ""
    var boxOfficeText: String = ""
    var genreText: String = ""
    var directorText: String = ""
    var ratedText: String = ""
    var releasedDateText: String = ""
    var titleText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        self.navigationItem.leftBarButtonItem = b
        let url = URL(string: self.imageLink)!
        downloadImage(from: url)
        self.actors.text = actorText
        self.runtime.text = runtimeText
        self.boxoffice.text = boxOfficeText
        self.genre.text = genreText
        self.director.text = directorText
        self.rated.text = ratedText
        self.releasedDate.text = releasedDateText
        self.titleOfMovie.text = titleText
    }
    @objc func cancelClicked () {
        self.dismiss(animated: true, completion: nil)
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.imageMovie.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
