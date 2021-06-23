//
//  ViewController.swift
//  SO Question: TableVCell with varying height
//
//  Created by BugDev Studios on 20/03/2019.
//  Copyright © 2019 BugDev Studios. All rights reserved.
//

import UIKit
import Kingfisher

struct CellItem {
  let title: String
  let subTitle: String
  let imageUrlStr : String
  
  var image : UIImage?
  
  init(title: String, subTitle: String, imageUrlStr: String) {
    self.title = title
    self.subTitle = subTitle
    self.imageUrlStr = imageUrlStr
    self.image = nil
    
  }
}

struct images {
  static let square150 = UIImage.init(named: "150")
  static let port200Cross100 = UIImage.init(named: "200x100")
}

struct strings {
  
  static let loremEpsumStr1 = "Lorem Ipsum"
  static let loremEpsumStr2 = "Lorem Ipsum"
  static let loremEpsumStr3 = "Lorem Ipsum"
  static let loremEpsumStr4 = "Lorem Ipsum"
  
}
class ViewController: UITableViewController {

  var arrayListItems = [CellItem]()
  let baseUrlStr = "https://via.placeholder.com/"
  let cellIdentifierTitle = "TableViewCellTitle"
  let cellIdentifierSubTitle = "TableViewCellSubTitle"
  let cellIdentifierImage  = "TableViewCellImage"
    
    var parentTableIndexPath : IndexPath!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fillArrayWithData()
    tableView.estimatedRowHeight = 30
    tableView.rowHeight = UITableView.automaticDimension
    tableView.reloadData()
    
    var postImages = [String]()
    postImages.removeAll()
    
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func fillArrayWithData(){

    var item = CellItem.init(title: "50 x 50", subTitle: strings.loremEpsumStr1, imageUrlStr: "https://www.ourshopee.com/ourshopee-img/ourshopee_subcategory/359661756Supermarket-Rice-Pasta-&-Pulses.png")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "100 x 50", subTitle: strings.loremEpsumStr2, imageUrlStr: "https://www.ourshopee.com/ourshopee-img/ourshopee_homebanners/58180678new-Fashion.jpg")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "50 x 100", subTitle: strings.loremEpsumStr3, imageUrlStr: "https://www.ourshopee.com/ourshopee-img/ourshopee_image_sliders/391568162TV-Banner-new.jpg")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "150 x 150", subTitle: strings.loremEpsumStr4, imageUrlStr: "https://www.ourshopee.com/images/under599.png")
    arrayListItems.append(item)
    
    
    
    
    item = CellItem.init(title: "100 x 50", subTitle: strings.loremEpsumStr2, imageUrlStr: "https://www.ourshopee.com/images/1-to-20.gif")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "50 x 100", subTitle: strings.loremEpsumStr3, imageUrlStr: "https://www.ourshopee.com/ourshopee-img/ourshopee_section_images/50017393saver-zone_Web.gif")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "150 x 150", subTitle: strings.loremEpsumStr4, imageUrlStr: "https://www.ourshopee.com/ourshopee-img/ourshopee_homebanners/27334684Clearence-sale.jpg")
    arrayListItems.append(item)
    
    
    
    
    item = CellItem.init(title: "100 x 50", subTitle: strings.loremEpsumStr2, imageUrlStr: "https://www.ourshopee.com/images/Perfumes-o.png")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "50 x 100", subTitle: strings.loremEpsumStr3, imageUrlStr: "https://www.ourshopee.com/ourshopee-img/ourshopee_banners/758650866eidsale-home.jpg?v=1")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "150 x 150", subTitle: strings.loremEpsumStr4, imageUrlStr: "https://www.ourshopee.com/images/under599.png")
    arrayListItems.append(item)
    
    
    
    
  }
    
    

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayListItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let cellImage = tableView.dequeueReusableCell(withIdentifier: cellIdentifierImage) as! TableViewCell
    
    
      let item = arrayListItems[indexPath.row]
      //if we already have the image, just show
      if let image = arrayListItems[indexPath.row].image {
        cellImage.imageViewPicture.image = image
      }else {
        if let url = URL.init(string: item.imageUrlStr) {
            cellImage.imageViewPicture.kf.setImage(with: url, completionHandler:  { [weak self] result in
                guard let strongSelf = self else { return } //arc
                // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                switch result {
                case .success(let value):
                    // The image was set to image view:
                    
                    print("=====Image Size \(value.image.size)"  )
                    strongSelf.arrayListItems[indexPath.row].image = value.image
                    DispatchQueue.main.async {
                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                    // From where the image was retrieved:
                    // - .none - Just downloaded.
                    // - .memory - Got from memory cache.
                    // - .disk - Got from disk cache.
                    print(value.cacheType)
                    
                    // The source object which contains information like `url`.
                    print(value.source)
                    
                case .failure(let error):
                    print(error) // The error happens
                }
            })
          
        }
        
      }
      
      
      return cellImage
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let image = arrayListItems[indexPath.row].image {
        
      let imageWidth = image.size.width
      let imageHeight = image.size.height
      
      guard imageWidth > 0 && imageHeight > 0 else { return UITableView.automaticDimension }
//      let Imageratio = imageWidth / imageWidth
      
      //images always be the full width of the screen
      let requiredWidth = tableView.frame.width
      
      let widthRatio = requiredWidth / imageWidth
      
      let requiredHeight = imageHeight * widthRatio
//      let newSize = CGSize.init(width: requiredWidth, height: requiredHeight)
      print("returned height \(requiredHeight) at indexPath: \(indexPath)")
      return requiredHeight
      
      
    } else {
        return UITableView.automaticDimension
    }
  }
  
}

