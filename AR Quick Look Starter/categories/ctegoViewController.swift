//
//  ctegoViewController.swift
//  AR Quick Look Starter
//
//  Created by dodo on 5/18/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var titlefood: UITextField!
    
    
    var catFood:[Categories] = []
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        getCat()
        
    }
    @IBAction func addCatFood(_ sender: Any) {
        
        let numberDate = Date.init().timeIntervalSince1970
        let fileName = numberDate.description + "_" + Int.random(in: 0...10000).description + ".jpg"
        
        
        let imageData  = image.image?.jpegData(compressionQuality: 0.5)
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/jpeg"
        
        let ref  = Storage.storage().reference().child("image").child(fileName)
        ref.putData(imageData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("upload successful")
                
                //get url
                
                ref.downloadURL(completion: { (url, error) in
                    if error == nil {
                        var pathUrl = url?.absoluteString
                        self.addCat(title: self.titlefood.text!, image: pathUrl ?? " ")
                    }
                })
            }
        }
        
        
        
        
        self.table.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(catFood.count) count is")
        return catFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell", for: indexPath) as! CatTableViewCell
        cell.titleCat.text = catFood[indexPath.row].title
        cell.imageCat.sd_setImage(with: URL(string: catFood[indexPath.row].image), completed: nil)
        
        return cell
        //        let cell = UITableViewCell()
        //        cell.textLabel?.text = catFood[indexPath.row].title
        //        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat  = catFood[indexPath.row]
        
        print("\(cat) id is cat")
        performSegue(withIdentifier: "item", sender: cat)
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "item" {
            let RVC = segue.destination as!  itemViewController
            RVC.cat = sender as! Categories
            print("\(RVC.cat?.id)")
            
        }
    }
    func addCat(title:String,image:String){
        catFood.removeAll()
        
        var ref = Database.database().reference().child("catrgories").childByAutoId()
        var dic = [String:String]()
        dic["title"] = title
        dic["image"] = image
        ref.setValue(dic){
            (error,ref) in
            if error == nil{
                print("ok")
                self.getCat()
                
            }
        }
        
        
    }
    func getCat(){
        var ref = Database.database().reference().child("catrgories")
        ref.observeSingleEvent(of: .value,  with: { (snapshot) in
            for cat in snapshot.children{
                let snap = cat as! DataSnapshot
                let id = snap.key
                let dic = snap.value as![String:String]
                self.catFood.append(Categories(id:id, title: dic["title"]!, image:  dic["image"]!))
                print(dic)
            }
            
            self.table.reloadData()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func openGallary(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image  = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        self.image.image = image
        
        
        
        picker.dismiss(animated: true, completion: nil)
    }
}


