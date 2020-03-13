//
//  TrialTableViewController.swift
//  TrialMonster
//
//  Created by Alex on 20/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit
import os.log


class TrialTableViewController: UITableViewController {
    // MARK: Outlets
     @IBOutlet var TrialTableView: UITableView!
    // MARK: Properties
    var trials = [Trial]()
    var resultsArray:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch result data from server
        getTrialResultList()

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trials.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "TrialTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrialTableViewCell else {
            fatalError("The dequeued cell is not an instance of TrialTableViewCell")
        }
        // Fetches the appropriate trial for the data source layout
        let trial = trials[indexPath.row]
        
        cell.clubLabel.text = trial.club
        cell.nameLabel.text = trial.name
        cell.dateLabel.text = trial.date
        cell.locationLabel.text = trial.location
        cell.permitLabel.text = trial.permit
        
        //MARK: Set colours for alternative rows
        cell.backgroundColor =  (indexPath.row % 2 == 0 ? UIColor.red.withAlphaComponent(0.05) : UIColor.white)
        
        return cell
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let ResultTableViewController = segue.destination as? ResultTableViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedTrialCell = sender as? TrialTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedTrialCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedTrial = trials[indexPath.row]
        ResultTableViewController.trial = selectedTrial
     }
     
    
    // MARK: Private methods

    
    // MARK: Get data from webserver
    func getTrialResultList(){
        let session = URLSession.shared
        let url = URL(string: "https://ios.trialmonster.uk/getTrialResultList.php")!
        let task = session.dataTask(with: url)
        { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else
            {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime=="text/html" else {
                print("Wrong MIME type!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                // print(json)
                self.resultsArray = json as! NSArray
                
                DispatchQueue.main.async {
                    self.displayData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func displayData() {
        for i in 0..<resultsArray.count {
            let trial = resultsArray[i] as! NSDictionary
            
            let id: Int = trial["id"] as! Int
            let date: String = trial["date"]  as! String
            let club: String = trial["club"]  as! String
            let name: String = trial["name"]  as! String
            let location: String = trial["location"] as! String
            let numlaps: Int    = trial["numlaps"] as! Int
            let numsections: Int    = trial["numsections"] as! Int
            let classlist: String = trial["classlist"] as! String
            let courselist: String = trial["courselist"] as! String
            let permit: String = trial["permit"] as! String
            
            trials.append((Trial(id: id, name: name, club: club, date: date, location: location, numsections: numsections, numlaps: numlaps, classlist: classlist, courselist: courselist, permit: permit) ?? nil)!)
            
        }
       // print(trials.count)
        TrialTableView.reloadData()
    } 
}
