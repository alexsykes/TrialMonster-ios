//
//  CourseCount.swift
//  TrialMonster
//
//  Created by Alex Sykes on 24/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class CourseCount: NSObject {
    // MARK: Properties
    var course: String
    var count: Int

    init(course: String, count: Int ) {
        self.count = count
        self.course = course
    }
}
