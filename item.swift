//
//  File.swift
//  
//
//  Created by dodo on 5/29/19.
//

import Foundation

import UIKit

class item {
    var id:String
    var title:String
    var image:String
    var companyName:String?
    var campanyLocation:String?
    var price:String?
    var Description:String?
    
    init(id:String,companyName:String,campanyLocation:String,Description:String, title:String,image:String,price:String)
    {
        self.companyName = companyName
        self.campanyLocation = campanyLocation
        self.Description = Description
        self.price = price
        self.id = id
        self.title = title
        self.image = image
        
    }
    
}

