//
//  PageItemController.swift
//  OMDb-API-Sample
//
//  Created by Andre Morais on 2/29/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    var pageIndex: Int!
    var imageName: String!
    
    @IBOutlet var contentImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        contentImageView?.image = UIImage(named: imageName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
