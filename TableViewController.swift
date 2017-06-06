//
//  TableViewController.swift
//  Names
//
//  Created by Sam Meech-Ward on 2017-06-05.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var names = ["placeholder"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        makeRequest()
        makeRequest()
        makeRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let name = names[indexPath.row]
        cell.textLabel?.text = name

        return cell
    }
    
    func makeRequest() {
        
        let url = URL(string: "https://swapi.co/api/people/")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                let peopleJSON = json as? [String: Any]
                
                if let people = peopleJSON?["results"] as? [[String: Any]] {
                    
                    // Names is empty
                    
                    for person in people {
                        let name = person["name"]
                        self.names.append(name as! String)
                        print("name \(String(describing: name))")
                    }
                    
                    // names is populated
                    
                    OperationQueue.main.addOperation {
                        // Any code that we put here, gets run on the main thread
                        self.tableView.reloadData()
                    }
                    
                } else {
                    print("Error getting results from json")
                }
                
            }
            
        }
        
        dataTask.resume()
        
        print("outside the closure")
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
