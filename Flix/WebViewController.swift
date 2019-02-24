//
//  WebViewController.swift
//  Flix
//
//  Created by Ashik Chowdhury on 2/15/19.
//  Copyright © 2019 Ashik Chowdhury. All rights reserved.
//

import UIKit
import WebKit



class WebViewController: UIViewController, WKUIDelegate  {
    
      struct Results {
        let id: String
        let iso_639_1: String
        let iso_3166_1: String
        let key: String
        let name: String
        let site: String
        let size: Int
        let type: String
    }
    var movies = [[String:Any]] ()
    var movie: [String:Any]!
    var movieKey = ""
    
    let dispatchGroup = DispatchGroup()
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self

            getVideo()
        
    }
    
    func run (after seconds:Int, completion: @escaping() -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func getVideo(){
        dispatchGroup.enter()
        let movieId = movie["id"]
        print (movieId!)
        run(after: 1) {
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    //                let movieResults = dataDictionary["results"]
                    //                print(movieResults)
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    let movieFirst = self.movies.first as! [String:Any]
                    self.movieKey = movieFirst["key"] as! String
                    print(self.movieKey)
                    self.dispatchGroup.leave()

                }
            }
            task.resume()
        }
        dispatchGroup.notify(queue: .main) {
            let myUrl = URL(string: "https://www.youtube.com/watch?v=\(self.movieKey)")!
            print(self.movieKey)
            print(myUrl)
            self.webView.load(URLRequest(url: myUrl))
        }
        
    }
   
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
