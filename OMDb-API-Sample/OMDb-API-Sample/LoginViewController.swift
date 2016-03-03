//
//  LoginViewController.swift
//  OMDb-API-Sample
//
//  Created by Andre Morais on 3/1/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func cpfTextFieldEditingChanged(sender: AnyObject) {
        applyFilter(cpfTextField, mask: "XXX.XXX.XXX-XX")
    }
    

    func applyFilter(textField:UITextField, mask:String){
        
        var index = mask.startIndex
        var textWithMask:String = ""
        var i:Int = 0
        var text:String = textField.text!
        
        if (text.isEmpty){
            return
        }
        
        text = removeMaskCharacters(text,withMask: mask)
        
        while(index != mask.endIndex){
            
            if(i >= text.characters.count){
                textField.text! = textWithMask
                break
            }
            
            if("\(mask[index])" == "X"){
                textWithMask = textWithMask + text[i]
                i++
            }else{
                textWithMask = textWithMask + "\(mask[index])"
            }
            
            index = index.successor()
        }
        
        textField.text! = textWithMask
        
    }
    
    func removeMaskCharacters(var text:String,var withMask mask:String) -> String{
        
        mask = mask.stringByReplacingOccurrencesOfString("X", withString: "")
        
        var index = mask.startIndex
        
        while(index != mask.endIndex){
            text = text.stringByReplacingOccurrencesOfString("\(mask[index])", withString: "")
            
            index = index.successor()
        }
        
        return text
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.cpfTextField.addTarget(self, action: "CPFFormatter:", forControlEvents: .EditingChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
//        if(segue.identifier == "SearchView"){
//            let viewController:SearchViewController = segue.destinationViewController as! SearchViewController
//            
//        }
        
    }


}
