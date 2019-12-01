//
//  loginViewController.swift
//  AR Quick Look Starter
//
//  Created by dodo on 7/31/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
   
    
    
    @IBAction func singUpClicked(_ sender: UIButton) {
        
        
     //   sender.pulse()
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                
                
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "Error", message: "email you needed", preferredStyle: UIAlertController.Style.alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alert.addAction(okButton)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    
                    
                    UserDefaults.standard.set(user?.email , forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as!AppDelegate
                    
                    delegate.rememberLogin()
                    
                }
                
                
                
                
            })
            
            
            
            
            
        }else{
            
            let alert = UIAlertController(title: "Error", message: "email you needed", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


