//
//  itemViewController.swift
//  AR Quick Look Starter
//
//  Created by dodo on 5/29/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import Firebase
class itemViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var titlefood: UITextField!
    
    var cat : Categories?
    
    var itemFood:[item] = []
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        getitem()
        
    }
  /*  @IBAction func additemFood(_ sender: Any) {
        additem(title: titlefood.text!, image: "url")
        self.table.reloadData()
    }
 
 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(itemFood.count) count is")
        print("\(cat?.id) id is")
        
        return itemFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! itemTableViewCell
        cell.titleitem.text = itemFood[indexPath.row].title
        
        return cell
        //        let cell = UITableViewCell()
        //        cell.textLabel?.text = catFood[indexPath.row].title
        //        return cell
    }
  /*  func additem(title:String,image:String){
        var ref = Database.database().reference().child("item").child((cat?.id)!).childByAutoId()
        var dic = [String:String]()
        dic["title"] = title
        dic["image"] = image
        
        ref.setValue(dic){
            (error,ref) in
            if error == nil{
                print("ok")
                
            }
            // self.getCat()
        }
        
        
    }
 *///
    func getitem(){
        var ref = Database.database().reference().child("item").child((cat?.id)!)
        ref.observeSingleEvent(of: .value,  with: { (snapshot) in
            for cat in snapshot.children{
                let snap = cat as! DataSnapshot
                let id = snap.key
                let dic = snap.value as![String:String]
                self.itemFood.append(item(id:id, title: dic["title"]!, image:  dic["image"]!))
                print(dic)
            }
            
            self.table.reloadData()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
 /*   @IBAction func openGallary(_ sender: Any) {
        
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
 */
}

