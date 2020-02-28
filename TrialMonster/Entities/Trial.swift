//
//  Trial.swift
//  TrialMonster
//
//  Created by Alex on 20/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class Trial: NSObject {
    // MARK: Properties
    var id: Int
    var name: String
    var club: String
    var date: String
    var numsections: Int
    var numlaps: Int
    var classlist: String!
    var courselist: String!
    var classes: [String]
    var courses: [String]
    var location: String
    var permit: String

    // MARK: Initialisation
    init?(id: Int, name: String, club: String, date: String, location: String, numsections: Int, numlaps: Int, classlist: String, courselist: String, permit: String) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        self.id = id
        self.name = name
        self.club = club
        self.date = date
        self.location = location
        self.classlist = classlist
        self.courselist = courselist
        self.numlaps = numlaps
        self.numsections = numsections
        self.classes = classlist.components(separatedBy: ",")
        self.courses = courselist.components(separatedBy: ",")
        self.permit = permit
    }

    // MARK: Initialisation
    init?(name: String, club: String, date: String, location: String, numsections: Int, numlaps: Int, classlist: String, courselist: String, permit: String) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        self.id = 999
        self.name = name
        self.club = club
        self.date = date
        self.location = location
        self.classlist = classlist
        self.courselist = courselist
        self.numlaps = numlaps
        self.numsections = numsections
        self.classes = classlist.components(separatedBy: ",")
        self.courses = courselist.components(separatedBy: ",")
        self.permit = permit
    }
}
