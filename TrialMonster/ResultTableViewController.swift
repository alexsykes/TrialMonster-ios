//
//  ResultTableViewController.swift
//  TrialMonster
//
//  Created by Alex Sykes on 25/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    // MARK: Properties
    var trial: Trial?
    
    var resultsArray: [Result] = []
    var coursesArray: [String] = []
    var numSectionsForDisplay: Int = 0
    
    // Dictionary key->courseName, value->[Result]
    var resultsByCourse: Dictionary<String, [Result]> = [String: [Result]]()
    
    var sections = [CourseSection]()
    
    struct CourseSection {
        var order: Int
        var course: String
    }
    
    // MARK: Outlets
    @IBOutlet weak var ClubLabel: UILabel!
    @IBOutlet weak var EventNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var VenueLabel: UILabel!
    @IBOutlet var ResultTableView: UITableView!
    @IBOutlet weak var ResultTableViewCell: ResultTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get trial data from trial
        EventNameLabel.text = trial?.name
        ClubLabel.text = trial?.club
        DateLabel.text = trial?.date
        VenueLabel.text = trial?.location
        
        //courses = trial!.courses
        numSectionsForDisplay = trial!.courses.count
        coursesArray = trial!.courses
        
        getTrialResultList()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return resultsByCourse.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ResultTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResultTableViewCell else {
            fatalError("The dequeued cell is not an instance of ResultTableViewCell")
        }
        // Fetches the appropriate trial for the data source layout
        let result = resultsArray[indexPath.row]
        
        cell.NameLabel.text = result.name
        cell.RiderLabel.text = result.rider
        cell.TotalLabel.text = result.total
        cell.CleansLabel.text = result.cleans
        cell.OnesLabel.text = result.ones
        cell.TwosLabel.text = result.twos
        cell.ThreesLabel.text = result.threes
        cell.FivesLabel.text = result.fives
        cell.MissedLabel.text = result.missed
        
        //MARK: Set colours for alternative rows
        cell.backgroundColor =  (indexPath.row % 2 == 0 ? UIColor.red.withAlphaComponent(0.05) : UIColor.white)
        
        return cell
    }
    
    // Added March 15
    // Ceate a standard header that includes the returned text
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return self.coursesArray[section] // "Header \(section)"
    }
    
    /*
    // Ceate a standard footer that includes the returned text
     override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String {
        return self.coursesArray[section] + " ends" // "Footer \(section) - ends"
    }
    */
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "ClassLabel", for: indexPath)
     return cell
     } */
    
    
    // End of additions
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: Get data from webserver
    func getTrialResultList(){
        let session = URLSession.shared
        let trialid = trial!.id
        let urlBase = "https://ios.trialmonster.uk/getJSONDataios.php?id=\(trialid)"
        let url = URL(string: urlBase)!
        //   print(url.absoluteString)
        
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
                
                // parse data from server into JSON Array
                let returnedArray = json as! NSArray
                
                // Index 0 is array of results
                // Index 1 is array of course data
                let resultsJSONArray = returnedArray[0] as! NSArray
                // let entryCountJSONArray = returnedArray[1] as! NSArray
                
                // Instantiate Result
                for index in 0..<resultsJSONArray.count{
                    let result = resultsJSONArray[index] as! NSDictionary
                    
                    let cleans: String = result["cleans"] as! String
                    let classs: String = result["class"] as! String
                    let course: String = result["course"] as! String
                    let created: String = result["created"] as! String
                    let fives: String = result["fives"] as! String
                    let id: String = result["id"] as! String
                    let machine: String = result["machine"] as! String
                    let missed: String = result["missed"] as! String
                    let name: String = result["name"] as! String
                    let ones: String = result["ones"] as! String
                    let rider: String = result["rider"] as! String
                    let scores: String = result["scores"] as! String
                    let sectionScores: String = result["sectionscores"] as! String
                    let threes: String = result["threes"] as! String
                    let total: String = result["total"] as! String
                    let trialid: String = result["trialid"] as! String
                    let twos: String = result["twos"] as! String
                    
                    // then add to resultsArray
                    self.resultsArray.append((Result(classs: classs, cleans: cleans, course: course, created: created, fives: fives, id: id, machine: machine, missed: missed, name: name, ones: ones, rider: rider, scores: scores, sectionScores: sectionScores, threes: threes, total: total, trialid: trialid, twos: twos) ?? nil)!)
                    
                    
                }
                
                // See - https://stackoverflow.com/questions/31220002/how-to-group-by-the-elements-of-an-array-in-swift - for Swift 5
                // Now group results according to course
                self.resultsByCourse = Dictionary(grouping: self.resultsArray) {$0.course}
                /*
                 At this point
                 ** resultsArray contains all results ordered ready for display
                 ** coursesArray contains ordered array of course names as Strings
                 ** groups contains grouped sets of Results
                 */
                
                
                DispatchQueue.main.async {
                    // self.displayData()
                    self.ResultTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
