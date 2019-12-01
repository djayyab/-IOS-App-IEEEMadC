//
//  singupViewController.swift
//  AR Quick Look Starter
//
//  Created by dodo on 7/31/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import Firebase


class singupViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    @IBOutlet weak var userName: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func singInClicked(_ sender: UIButton) {
    
        guard let email = emailText.text, let password = passwordText.text, let name = userName.text else {
            print("Form is not valid")
            return
        }
       
     
     
        if emailText.text != "" && passwordText.text != "" && userName.text != ""{
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alert.addAction(okButton)
                    
                  self.present(alert, animated: true, completion: nil)
                    
                    
                    
                    
                }else{
            
            guard let uid = user?.uid else {
            return
            }
            
            //successfully authenticated user
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
           
            
            if let err = err {
            print(err)
            return
            }
            
        // self.dismiss(animated: true, completion: nil)
            })
            
         
            
            
            
            
                    
               self.performSegue(withIdentifier: "toTapBar", sender: nil)
     
                    
                }
                
                
                
                
                
                
                
            })
            
        }else{
            
            let alert = UIAlertController(title: "Error", message: "email you needed", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
}
    
}
        

           
            



