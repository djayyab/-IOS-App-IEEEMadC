

import UIKit
import Foundation
import QuickLook
import FirebaseDatabase
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource{
    
    
    
    var cat : Categories?
    var itemFur:[item] = []
    
    
    @IBOutlet var collectionView: UICollectionView!
    let models = ["Office Chair3","redchair","Office chair","Wooden Chair","Office Chair2"]
    
   // var thumbnails = [UIImage]()
    var thumbnailIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getitem()
        collectionView.reloadData()
        
     //   when use image in Assets
        /**for model in models {
            if let thumbnail = UIImage(named: "\(model).jpg") {
                thumbnails.append(thumbnail)
            }
        }
        ***/
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  return models.count
        print("\(itemFur.count) count is")
        print("\(String(describing: cat?.id)) id is")
        
        return itemFur.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCell", for: indexPath) as? LibraryCollectionViewCell
        
        if let cell = cell {
        // cell.modelThumbnail.image = thumbnails[indexPath.item]
           cell.modelTitle.text = itemFur[indexPath.item].title
           cell.modelThumbnail!.sd_setImage(with:URL(string: itemFur[indexPath.item].image) , completed: nil)
           let title = models[indexPath.item]
           cell.modelTitle.text = title.capitalized
           cell.more.tag = indexPath.item
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        thumbnailIndex = indexPath.item
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        present(previewController, animated: true)
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let file =  models[thumbnailIndex]
        let url = Bundle.main.url(forResource:file , withExtension: "usdz")!
        return url as QLPreviewItem
    }
    
    func getitem(){
        let ref = Database.database().reference().child("item").child((cat?.id)!)
        ref.observeSingleEvent(of: .value,  with: { (snapshot) in
            for cat in snapshot.children{
                let snap = cat as! DataSnapshot
                let id = snap.key
                if let dic = snap.value as?[String:Any]{
                    self.itemFur.append(item(id:id, companyName:dic["campany name"]! as! String, campanyLocation: dic["company location"]! as! String, Description: dic["description"]! as! String, title: dic["title"]! as! String, image:  dic["image"]! as! String, price: dic["price"]! as! String))
                    print(dic)
                }
            }

         self.collectionView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
   
    @IBAction func tapMore(_ sender: UIButton) {
        // var cell = collectionView.
        let rowIndex:Int = sender.tag
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailesViewController")as?detailesViewController
        vc?.itemId = rowIndex
        print(rowIndex)
        vc?.itemobj = itemFur[rowIndex]
        // vc?.img = itemFur[rowIndex].image
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
