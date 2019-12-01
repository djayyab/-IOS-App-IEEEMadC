//
//  detailesViewController.swift
//  AR Quick Look Starter
//
//  Created by dodo on 7/12/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import FirebaseDatabase

class detailesViewController: UIViewController {
    
   var itemId:Int?
   var cat : Categories?
   var itemobj:item?
   
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var campanyLocation: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImage.image = img
        
        campanyLocation.text = itemobj?.campanyLocation
        companyName.text = itemobj?.companyName
        Description.text =  itemobj?.Description
        price.text = itemobj?.price
        imageTitle.text = itemobj?.title
        
        
        itemImage!.sd_setImage(with:URL(string: ((itemobj?.image ?? nil) ?? nil)!) , completed: nil)
        
        //  itemImage.sd_setImage(with: , completed: nil) = //itemobj?.image
        
        // Do any additional setup after loading the view.
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }*/
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }




}
