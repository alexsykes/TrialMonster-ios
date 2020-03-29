//
//  DetailCollectionViewController.swift
//  TrialMonster
//
//  Created by Alex Sykes on 28/03/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class DetailCollectionViewController: UICollectionViewController {
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let reuseIdentifier = "SectionScoreCell"
    var result: Result?
    var trial: Trial?
    var scores: String?
    var numTrialSections: Int?
    var numLaps: Int?
    
    var sectionScores: [SectionScores] = []
    var sectionScoreArray: [String] = []
    
    struct SectionScores {
        var section: Int!
        var scores: String!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scores = result?.sectionscores
        numTrialSections = trial?.numsections
        numLaps = trial?.numlaps
        
        sectionScoreArray = scores!.split(by: numLaps!)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(SectionScoreCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sectionScoreArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> SectionScoreCollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as? SectionScoreCollectionViewCell)!
                let  number = "2"
        let scores = "0111"
    //    cell.setup(section: number, score: scores)
        
        
        //   let scoreString: String = sectionScoreArray[indexPath.row]
          cell.sectionScoresLabel.text = scores
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
    
    
    // Added from https://stackoverflow.com/questions/32212220/how-to-split-a-string-into-substrings-of-equal-length#38980231
}
extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        
        return results.map { String($0) }
    }
}
