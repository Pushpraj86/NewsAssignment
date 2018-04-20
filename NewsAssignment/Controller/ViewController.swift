//
//  ViewController.swift
//  NewsAssignment
//
//  Created by Marketgoal on 20/04/18.
//  Copyright © 2018 Marketgoal. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var NewsDetails = [NewsSource]()
    
    @IBOutlet weak var tblNewsView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Most Recent Headlines"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        tblNewsView.estimatedRowHeight = 90.0
        tblNewsView.rowHeight = UITableViewAutomaticDimension
        
        self.callWS()
    }
    
    func callWS()   {
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=f1dc95654c6f47db8e66631e50f0ff1c"
        
        let url = URL(string: urlString)
        
       
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                self.NewsDetails = try [JSONDecoder().decode(NewsSource.self, from: data)]
                
               
                DispatchQueue.main.async {
                     self.activityIndicator.stopAnimating()
                    self.tblNewsView.reloadData()
                }
                
                
            } catch  {
                print(error.localizedDescription)
                
            }
            
        }).resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.NewsDetails.count > 0 {
            return self.NewsDetails[0].results.count
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Newscell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsCell
        
        let str : String? = self.NewsDetails[0].results[indexPath.row].media[0].mediaMetadata[0].url
        cell.imgView.sd_setImage(with: NSURL(string: str ?? "") as URL!, placeholderImage:nil)

        cell.lblTitle.text = self.NewsDetails[0].results[indexPath.row].title
        cell.lblAuthor.text = self.NewsDetails[0].results[indexPath.row].byline
        cell.lblDate.text = self.NewsDetails[0].results[indexPath.row].publishedDate
        
        return cell
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNews" {
            if let indexPath = tblNewsView.indexPathForSelectedRow {
                let controller = segue.destination as! WebViewController
                controller.selectedUrl = self.NewsDetails[0].results[indexPath.row].url
            }
        }
    }
    
}


