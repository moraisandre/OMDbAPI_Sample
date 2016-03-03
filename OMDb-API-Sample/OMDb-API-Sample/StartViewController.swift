//
//  StartViewController.swift
//  OMDb-API-Sample
//
//  Created by Andre Morais on 2/29/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    var pageImage: NSArray!
    
    @IBOutlet weak var getStartBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageImage = NSArray(objects: "intro1","intro2","intro3")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as PageItemController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 10, self.view.frame.width, self.view.frame.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }

    @IBAction func getStated(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("NavController") as! NavController
        self.presentViewController(nextViewController, animated:false, completion:nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> PageItemController{
        if((self.pageImage.count == 0) || (index >= self.pageImage.count)){
            return PageItemController()
        }
        
        let vc:PageItemController = self.storyboard?.instantiateViewControllerWithIdentifier("PageItemController") as! PageItemController
        
        vc.imageName = self.pageImage[index] as! String
        vc.pageIndex = index
        
        
        
        return vc
    }
    
    func showButton(index: Int){
        
        if (index == 2){
            getStartBtn.hidden = false
        }
    }
    
    // Mark - PageView Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! PageItemController
        var index = vc.pageIndex as Int
        
        //showButton(index)
        
        if(index == 0 || index == NSNotFound){
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! PageItemController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound){
            return nil
        }
        
        showButton(index)
        
        index++
        
        if (index == self.pageImage.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageImage.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
