//
//  ViewController.swift
//  Tableviewswift
//
//  Created by Pavani_ios on 7/28/17.
//  Copyright © 2017 asman. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let cellReuseIdentifier = "cell"

    
    var dataArray :[[String : Any]] = []

    @IBOutlet weak var datatableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.getServiceCall()
       // datatableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
      //  self.getServiceCallMethod()
        self.almafireServiceCall()


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func almafireServiceCall() {
    
    // let parameters: Parameters = ["foo": "bar"]
    let urlstring:String =  "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/10/explicit/json"
    //let url = URL(string: urlstring)
    let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    print(escapedString)
    //        let newString = escapedString.replacingOccurrences(of:" ", with:"")
    
    Alamofire.request(escapedString!, method: .get, parameters: nil, encoding: JSONEncoding.default)
      .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
     print("Progress: \(progress.fractionCompleted)")
     }
     .validate { request, response, data in
         let JSONResponse:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
        self.dataArray = (JSONResponse["feed"] as! NSDictionary).value(forKey: "results") as! Array

        DispatchQueue.main.async   {
            self.datatableview.reloadData()
        }

     return .success
     }
   /* .responseJSON (queue: DispatchQueue.global(qos: .userInteractive)) { response in
    
    //                if let responseDict = response.data?.JSONObject() as? JSON, let jsonString = responseDict.JSONString() {
    
    
        let JSONResponse:NSDictionary = try! JSONSerialization.jsonObject(with: (response.data)!, options: []) as! NSDictionary
        
    
        self.dataArray = (JSONResponse["feed"] as! NSDictionary).value(forKey: "results") as! Array

    DispatchQueue.main.async {
    
        self.datatableview.reloadData()

    }
    
    debugPrint(response)
    
    }*/ 
    }
    func getServiceCallMethod() {
        
        
//        https://gist.github.com/ashishkakkad8/7c599c6e052d722b0083
        //"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=095711373620570aa92ee530246dc8af"
        
       // https://itunes.apple.com/in/rss/newapplications/limit=10/json
        let url:NSURL = NSURL(string: "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/10/explicit/json")!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        //  request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            do {
                guard let todo:Dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                //(foodTypesArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "FOOD_GRID_IMAGE")
                self.dataArray.removeAll()
                self.dataArray = (todo["feed"] as! NSDictionary).value(forKey: "results") as! Array
                print(self.dataArray.count)

                DispatchQueue.main.async() {
                    self.datatableview.reloadData()
                }
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    
    
    
    func getServiceCall() {
    
    
        let todoEndpoint: String = "https://itunes.apple.com/search?term=jack+johnson&limit=25&media=music&entity=musicArtist,musicTrack,album,mix,song"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)

        let config = URLSessionConfiguration.default
        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                // check for any errors
                guard error == nil else {
                    print("error calling GET on /todos/1")
                    print(error ?? nil)
                    return
                }
                // make sure we got data
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                // parse the result as JSON, since that's what the API provides
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    
                    
                    // ...
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
        })
        task.resume()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if dataArray.count > 0{
            return dataArray.count

        }else{
            return 0
        }
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // create a new cell if needed or reuse an old one
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomTableViewCell!
        
//        let subViews = cell.subviews
//        for subview in subViews{
//            subview.removeFromSuperview()
//        }
        // set the text from the data model
       let dict : Dictionary = dataArray [indexPath.row] as Dictionary
        
        if ((dict ["artistName"]  as? String) != nil){
            cell?.artistName?.text = dict ["artistName"]  as? String
        }
        let urlstring = dict ["artworkUrl100"]  as? String
        if urlstring != nil{
        let url = NSURL(string: urlstring!)
        
      //  DispatchQueue.global(qos: .background).async {
            
            let imageData:NSData = NSData(contentsOf: url! as URL)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell?.urlimageview?.image = image
            }
        // }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let colletionView = storyboard.instantiateViewController(withIdentifier: "ColletionView") as! CollectionViewController
//        self.navigationController?.pushViewController(colletionView, animated: true)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailsView = storyboard.instantiateViewController(withIdentifier: "DetailsPage") as! TableviewDetailsViewController
        detailsView.detailsDictionary = (dataArray[indexPath.row] as? Dictionary)!
        self.navigationController?.pushViewController(detailsView, animated: true)

        
        
    }
}


