//
//  SearchViewController.swift
//  OMDb-API-Sample
//
//  Created by Andre Morais on 3/1/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var moviesInfoJson:JSON = []
    var moviesValueArray:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "ResultView"){
            let viewController:ResultsTableViewController = segue.destinationViewController as! ResultsTableViewController
            viewController.title = "Resultados"
            
            viewController.movieName = searchField.text!
        }
        
    }


}
