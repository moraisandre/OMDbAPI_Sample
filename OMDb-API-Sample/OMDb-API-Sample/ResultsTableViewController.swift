//
//  ResultsTableViewController.swift
//  OMDb-API-Sample
//
//  Created by Andre Morais on 3/1/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var moviesJson:JSON = []
    var movieName:String!
    var finishLoading:Bool = false
    
    var selectedMovieName:String!
    var selectedMovieID:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMovie()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchMovie() {
        //JSON
        movieName = movieName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        movieName = movieName.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        movieName = movieName.stringByReplacingOccurrencesOfString("'", withString: "%27")
        
        
        let url = NSURL(string: "http://www.omdbapi.com/?s="+movieName)
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:
            { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if data != nil {
                    self.moviesJson = JSON(data: data!)
                    
                    self.finishLoading = true                    
                    
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
        
        if(moviesJson["Search"].count == 0 && finishLoading){
            return 1
        }
        
        return moviesJson["Search"].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(moviesJson["Search"].count == 0 && finishLoading){
            var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reuseIdentifier")
            
            cell!.textLabel?.text = "Nenhum filme encontrado!"
            cell!.detailTextLabel?.text = "Tente novamente"
            
            return cell!
        }
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reuseIdentifier")
        
        let movieNameWithYear = moviesJson["Search"][indexPath.row]["Title"].stringValue + " (" + moviesJson["Search"][indexPath.row]["Year"].stringValue + ")"
        cell!.textLabel?.text = movieNameWithYear
        cell!.detailTextLabel?.text = moviesJson["Search"][indexPath.row]["Year"].stringValue + " " + moviesJson["Search"][indexPath.row]["Type"].stringValue
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(moviesJson["Search"].count == 0 && finishLoading){
            return
        }
        
        selectedMovieID = moviesJson["Search"][indexPath.item]["imdbID"].stringValue
        selectedMovieName = moviesJson["Search"][indexPath.item]["Title"].stringValue
        
        self.performSegueWithIdentifier("MovieDetailView", sender: self)
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let viewController:MovieDetailTableViewController = segue.destinationViewController as! MovieDetailTableViewController
        viewController.movieID = selectedMovieID
        viewController.title = selectedMovieName
    }
    

}
