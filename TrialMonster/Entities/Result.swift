//
//  Result.swift
//  TrialMonster
//
//  Created by Alex Sykes on 24/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class Result: NSObject {
    
    // MARK: Properties
    var classs: String
    var cleans: String
    var course: String
    var created: String
    var fives: String
    var id: String
    var machine: String
    var missed: String
    var name: String
    var ones: String
    var rider: String
    var scores: String
    var sectionscores: String
    var threes: String
    var total: String
    var trialid: String
    var twos: String
    var courseIndex: Int

    // MARK: Initialisation
    init?(classs: String, cleans: String, course: String , created: String, fives: String, id: String, machine: String, missed: String,
          name: String, ones: String, rider: String, scores: String, sectionScores: String, threes: String, total: String, trialid: String, twos: String, courseIndex: Int) {
        self.classs = classs
        self.cleans = cleans
        self.course = course
        self.created = created
        self.fives = fives
        self.id = id
        self.machine = machine
        self.missed = missed
        self.name = name
        self.ones = ones
        self.rider = rider
        self.scores = scores
        self.sectionscores = sectionScores
        self.threes = threes
        self.total = total
        self.trialid = trialid
        self.twos = twos
        self.courseIndex = courseIndex
    }
    
}
