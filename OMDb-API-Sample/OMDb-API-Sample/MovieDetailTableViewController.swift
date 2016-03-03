//
//  MovieDetailTableViewController.swift
//  OMDb-API-Sample
//
//  Created by Andre Morais on 3/1/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var movieID:String!
    var movieName:String!
    var movieInfoJson:JSON = []
    var movieKeysArray:NSArray = ["Title", "Year", "Rated", "Released", "Runtime", "Genre", "Director", "Writer", "Actors", "Plot", "Language", "Country", "Awards", "Metascore", "imdbRating", "imdbVotes", "Type"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieDetails()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieDetails() {
        //JSON
        
        let url = NSURL(string: "http://www.omdbapi.com/?i="+movieID)
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:
            { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if data != nil {
                    self.movieInfoJson = JSON(data: data!)

                    self.tableView.reloadData()
                }
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieKeysArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reuseIdentifier")
        
        let key:String = (movieKeysArray[indexPath.row] as? String)!
        
        cell!.textLabel?.text = movieInfoJson[key].stringValue
        cell!.detailTextLabel?.text = key
    
        
        return cell!
    }
    
}
