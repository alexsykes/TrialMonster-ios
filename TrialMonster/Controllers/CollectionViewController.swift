//
//  CollectionViewController.swift
//  TrialMonster
//
//  Created by Alex Sykes on 29/03/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    //MARK: variables
    var result: Result!
    var trial: Trial!
    var numLaps: Int!
    var numSections: Int!
    var section: Int!
    var scores: String?
    
    var sectionScoreArray: [String] = []
    
    //MARK: Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numSections = trial.numsections
        numLaps = trial.numlaps
        section = 0
        
        scores = result?.sectionscores
        sectionScoreArray = scores!.split(by: numLaps!)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = "Section: \(section + 1)"
        }
        
        if let label2 = cell.viewWithTag(101) as? UILabel {
            label2.text = sectionScoreArray[section]
        }
        
        section += 1
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
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1
        switch kind {
        // 2
        case UICollectionView.elementKindSectionHeader:
            //3
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(HeaderCollectionReusableView.self)",
                    for: indexPath) as? HeaderCollectionReusableView
                else {
                    fatalError("Invalid view type")
            }
            let name: String = result.name
            let number: String = result.rider
            var course: String = result.course
            let classs: String = result.classs
            let machine: String = result.machine
            
            if (classs != "") {
                course = course + " - " + classs
            }
            
            headerView.nameLabel.text = number + " - " + name
            headerView.courseLabel.text = course
            headerView.machineLabel.text = machine
            
            return headerView
        default:
            // 4
            assert(false, "Invalid element type")
        
        }
    }
    
    
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
