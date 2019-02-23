//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Ashik Chowdhury on 2/14/19.
//  Copyright © 2019 Ashik Chowdhury. All rights reserved.
//

import UIKit

class MovieGridDetailsViewController: UIViewController {
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let backDropPath = movie["backdrop_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        let backDropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backDropPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        backDropView.af_setImage(withURL: backDropUrl!)
        
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myWebViewController = segue.destination as! WebViewController
        myWebViewController.movie = movie
        }
    

}