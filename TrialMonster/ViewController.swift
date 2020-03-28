//
//  ViewController.swift
//  TrialMonster
//
//  Created by Alex on 20/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    // MARK: Properties
    var trial: Trial?
    
    var entrantsOnCourseArray: [CourseCount] = []
    var resultsArray: [Result] = []
    
    // MARK: Outlets
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var resultTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // MARK:  Set up trial data
//        let numSectionsInTable = trial?.classes.count
//        let courselist = trial?.courses
//        let classes = trial?.classes
//        let id = trial!.id
        getTrialResultList()
    }
    // MARK: Utility methods
    
    
    
    // MARK: Get data from webserver
    func getTrialResultList(){
        let session = URLSession.shared
        let trialid = trial!.id
        let urlBase = "https://android.trialmonster.uk/getJSONDataios.php?id=\(trialid)"
        let url = URL(string: urlBase)!
        //   print(url.absoluteString)
        
        let task = session.dataTask(with: url)
        { data, response, error in
            if error != nil || data == nil {
                //  print("Client error!")
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
                
                let returnedArray = json as! NSArray
                // print(json)
                let resultsJSONArray = returnedArray[0] as! NSArray
                let entryCountJSONArray = returnedArray[1] as! NSArray
                
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
                    
                    let courseIndex: Int = -999
                    
                    self.resultsArray.append((Result(classs: classs, cleans: cleans, course: course, created: created, fives: fives, id: id, machine: machine, missed: missed, name: name, ones: ones, rider: rider, scores: scores, sectionScores: sectionScores, threes: threes, total: total, trialid: trialid, twos: twos, courseIndex: courseIndex) ?? nil)!)
                }
                
                
                for index in 0..<entryCountJSONArray.count {
                    let entrycount = entryCountJSONArray[index] as! NSDictionary
                    
                    let countString: String = entrycount["count"] as! String
                    let count: Int = Int(countString)!
                    let coursename: String = entrycount["coursename"] as! String
                    
                    self.entrantsOnCourseArray.append(CourseCount(course: coursename, count: count))
                }
                
                DispatchQueue.main.async {
                    // self.displayData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
