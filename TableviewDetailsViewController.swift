//
//  TableviewDetailsViewController.swift
//  Tableviewswift
//
//  Created by Pavani_ios on 8/2/17.
//  Copyright © 2017 asman. All rights reserved.
//

import UIKit

class TableviewDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var DetailTable: UITableView!
    let cellReuseIdentifier1 = "cellidentifier"
    var detailsDictionary = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailsDictionary)

         DetailTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // create a new cell if needed or reuse an old one
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier1) as UITableViewCell!
        
        if indexPath.row == 0 {
            cell.textLabel?.text = detailsDictionary["name"] as? String;
        }else if indexPath.row == 1 {
            cell.textLabel?.text = detailsDictionary["primaryGenreName"] as? String;
        }else{
            cell.textLabel?.text = detailsDictionary["trackExplicitness"] as? String;
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
