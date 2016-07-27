//
//  ViewController.swift
//  SearchingDemo
//
//  Created by MindLogic Solutions on 23/05/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var popupClientFullName:[String]=[]
    var popupClientCurrentAddress:[String]=[]
    var popupClientPhotoLink:[String]=[]
    var popupClientAge:[String]=[]
    var popupClientHeight:[String]=[]
    var popupClientID:[String]=[]
    
    
    
    var SearchpopupClientFullName:[String]=[]
    var SearchpopupClientCurrentAddress:[String]=[]
    var SearchpopupClientPhotoLink:[String]=[]
    var SearchpopupClientAge:[String]=[]
    var SearchpopupClientHeight:[String]=[]
    var SearchpopupClientID:[String]=[]
    
    
    
    var shouldShowSearchResults = false

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.searchBar.delegate = self
       

        
        tblView.tableFooterView=UIView()
        getClientList()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowSearchResults
        {
            return SearchpopupClientFullName.count
        }
        
        return self.popupClientPhotoLink.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell=tblView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        if shouldShowSearchResults
        {
            if SearchpopupClientPhotoLink[indexPath.row] == "https://yismach.com/profiles/thumbnail_"
            {
                
                let proimg=cell.viewWithTag(1)as! UIImageView
                proimg.image=UIImage(named: "noprofile.jpg")
                
            }else{
                
                //SDWebImage code for retrieving profile icon
                let proimg=cell.viewWithTag(1)as! UIImageView
                let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
                }
                let url = NSURL(string:SearchpopupClientPhotoLink[indexPath.row])
                proimg.sd_setImageWithURL(url, completed: block)
            }
            
            
            let lbl1=cell.viewWithTag(2)as! UILabel
            
                lbl1.text = SearchpopupClientFullName[indexPath.row]
                lbl1.font = UIFont.systemFontOfSize(17)
            
            
            
            let lbl2=cell.viewWithTag(3)as! UILabel
            lbl2.text = "Age,\(SearchpopupClientAge[indexPath.row]) Height \(SearchpopupClientHeight[indexPath.row])"
            lbl2.textColor=UIColor(red: 255.0/255.0, green: 6.0/255.0, blue: 99.0/255.0, alpha: 1)
            lbl2.font = UIFont.systemFontOfSize(11)
            
            let lbl3=cell.viewWithTag(4)as! UILabel
            lbl3.text = SearchpopupClientCurrentAddress[indexPath.row]
            lbl3.textColor=UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 228.0/255.0, alpha: 1)
            lbl3.font = UIFont.systemFontOfSize(11)
        }
        else
        {
            if popupClientPhotoLink[indexPath.row] == "https://yismach.com/profiles/thumbnail_"
            {
                
                let proimg=cell.viewWithTag(1)as! UIImageView
                proimg.image=UIImage(named: "noprofile.jpg")
                
            }else{
                
                //SDWebImage code for retrieving profile icon
                let proimg=cell.viewWithTag(1)as! UIImageView
                let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
                }
                let url = NSURL(string:popupClientPhotoLink[indexPath.row])
                proimg.sd_setImageWithURL(url, completed: block)
            }
            
            
            let lbl1=cell.viewWithTag(2)as! UILabel
            
                lbl1.text = popupClientFullName[indexPath.row]
                lbl1.font = UIFont.systemFontOfSize(17)
            
            
            
            let lbl2=cell.viewWithTag(3)as! UILabel
            lbl2.text = "Age,\(popupClientAge[indexPath.row]) Height \(popupClientHeight[indexPath.row])"
            lbl2.textColor=UIColor(red: 255.0/255.0, green: 6.0/255.0, blue: 99.0/255.0, alpha: 1)
            lbl2.font = UIFont.systemFontOfSize(11)
            
            let lbl3=cell.viewWithTag(4)as! UILabel
            lbl3.text = popupClientCurrentAddress[indexPath.row]
            lbl3.textColor=UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 228.0/255.0, alpha: 1)
            lbl3.font = UIFont.systemFontOfSize(11)
        }
        
        return cell
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        if searchBar.text!.isEmpty{
            shouldShowSearchResults = false
            tblView.reloadData()
        } else {
            shouldShowSearchResults = true
            removeAllSearchArray()
            
            for i in 0..<popupClientFullName.count
            {
                let name = popupClientFullName[i] 

                if name.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil
                {
                    SearchpopupClientFullName.append(popupClientFullName[i])
                    SearchpopupClientCurrentAddress.append(popupClientCurrentAddress[i])
                    SearchpopupClientPhotoLink.append(popupClientPhotoLink[i])
                    SearchpopupClientAge.append(popupClientAge[i])
                    SearchpopupClientHeight.append(popupClientHeight[i])
                    SearchpopupClientID.append(popupClientID[i])
                }
            }
            
            tblView.reloadData()
        }
    }
    
    func removeAllSearchArray()
    {
        if !SearchpopupClientFullName.isEmpty
        {
            SearchpopupClientFullName.removeAll(keepCapacity: true)
        }
        if !SearchpopupClientCurrentAddress.isEmpty
        {
            SearchpopupClientCurrentAddress.removeAll(keepCapacity: true)
        }
        if !SearchpopupClientPhotoLink.isEmpty
        {
            SearchpopupClientPhotoLink.removeAll(keepCapacity: true)
        }
        if !SearchpopupClientAge.isEmpty
        {
            SearchpopupClientAge.removeAll(keepCapacity: true)
        }
        if !SearchpopupClientHeight.isEmpty
        {
            SearchpopupClientHeight.removeAll(keepCapacity: true)
        }
        if !SearchpopupClientID.isEmpty
        {
            SearchpopupClientID.removeAll(keepCapacity: true)
        }
    }
    
    func getClientList(){
        _ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.GET("https://yismach.com/androidapi/listclient_new4.php?txtclientid=4365&txtUserlevel=3&txtShadchanid=33",parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                        
                        var json :AnyObject!
                        
                        json = (try! NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
                        
                        if json["success"] as! Int == 1
                        {
                            
                            if let dict = json as? [String: AnyObject] {
                                json = dict["allclientlist"] as! Array<AnyObject>
                            }
                            let col = json as! Array<Dictionary<String,AnyObject>>
                            
                            for json in col{
                                
                                if json["client_fullname"] != nil
                                {
                                    let client_fullname = json["client_fullname"] as! String
                                    self.popupClientFullName.append(client_fullname)
                                }
                                
                                if json["client_photo1"] != nil
                                {
                                    let client_photo1 = json["client_photo1"] as! String
                                    self.popupClientPhotoLink.append(client_photo1)
                                }
                                
                                if json["client_currentLocation"] != nil
                                {
                                    let client_currentLocation = json["client_currentLocation"] as! String
                                    self.popupClientCurrentAddress.append(client_currentLocation)
                                }
                                
                                if json["client_age"] != nil
                                {
                                    let client_age = json["client_age"] as! Int
                                    self.popupClientAge.append("\(client_age)")
                                }
                                
                                if json["client_height_feet"] != nil
                                {
                                    let client_height_feet = json["client_height_feet"] as! String
                                    self.popupClientHeight.append(client_height_feet)
                                }
                                
                                if json["client_id"] != nil
                                {
                                    let client_id = json["client_id"] as! String
                                    self.popupClientID.append(client_id)
                                }
                                
                            }
                            
                        }
                        else
                        {
                            let alrt:UIAlertView=UIAlertView(title: "Yismach", message: "failed to fetch results..", delegate: nil, cancelButtonTitle: "OK")
                            alrt.show()
                        }
                        self.tblView.reloadData()
                        MBProgressHUD.hideHUDForView(self.view, animated: true)
            },
                    failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                        print("Error: " + error.localizedDescription)
                        MBProgressHUD.hideHUDForView(self.view, animated: true)
                        
        })
    }


}

