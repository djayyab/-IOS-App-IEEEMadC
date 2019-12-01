//
//  CatViewController.swift
//  AR Quick Look Starter
//
//  Created by dodo on 5/29/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//
import UIKit
import Firebase
import SDWebImage
class CatViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBAction func logoutButton(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        let singIn = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController")
        let delegate :AppDelegate = UIApplication.shared.delegate as!AppDelegate
        delegate.window?.rootViewController = singIn
        delegate.rememberLogin()
    }
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    var searchcatFur = [Categories]()
    var catFur:[Categories] = []
    var catFurTitle = [String]()
    var searching = false
   
   // @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchcatFur = catFur
        table.dataSource = self
        table.delegate = self
        getCat()
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
           return searchcatFur.count
            
        }else{
            return catFur.count
               print("\(catFur.count) count is")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell", for: indexPath) as! CatTableViewCell
        if searching{
            
            cell.titleCat.text = searchcatFur[indexPath.row].title
           
        }
        else{
           cell.titleCat.text = catFur[indexPath.row].title
          
           cell.imageCat.sd_setImage(with: URL(string: catFur[indexPath.row].image), completed: nil)
            
            catFurTitle.append (catFur[indexPath.row].title)
        }
        
       
        
        return cell
        //        let cell = UITableViewCell()
        //        cell.textLabel?.text = catFood[indexPath.row].title
        //        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat  = catFur[indexPath.row]
        
        print("\(cat) id is cat")
        performSegue(withIdentifier: "item", sender: cat)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "item" {
            let RVC = segue.destination as! ViewController
            RVC.cat = sender as? Categories
            print("\(String(describing: RVC.cat?.id))")
            
        }
    }
 func addCat(title:String,image:String){
        catFur.removeAll()
        
    let ref = Database.database().reference().child("categories").childByAutoId()
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
        let ref = Database.database().reference().child("categories")
        ref.observeSingleEvent(of: .value,  with: { (snapshot) in
            if snapshot.hasChildren(){
                
            for cat in snapshot.children{
                let snap = cat as! DataSnapshot
                let id = snap.key
                let dic = snap.value as![String:String]
               self.catFur.append(Categories(id:id, title: dic["title"]!, image:  dic["image"]!))
                print(dic)
                }
                
            }
            
          self.table.reloadData()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

/*
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
*/
}
extension CatViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else{
          searchcatFur = catFur
            table.reloadData()
            return
            
        }
      //  var text  = searchBar.text!
        searchcatFur = catFur.filter({ Categories -> Bool in
            guard let text = searchBar.text else {return false}
            
           return Categories.title.lowercased().contains(text.lowercased())
            
         })
        searching = true
        table.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        table.reloadData()
    }
    
    
    
}


