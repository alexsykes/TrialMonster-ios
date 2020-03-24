//
//  GroupedSection.swift
//  TrialMonster
//
//  Created by Alex on 18/03/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

// License     https://opensource.org/licenses/MIT
// License     https://creativecommons.org/publicdomain/zero/1.0/
// Source      https://www.ralfebert.de/ios-examples/uikit/uitableviewcontroller/grouping-sections/

struct GroupedSection<SectionItem : Hashable, RowItem> {

    var sectionItem : SectionItem
    var rows : [RowItem]

    static func group(rows : [RowItem], by criteria : (RowItem) -> SectionItem) -> [GroupedSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: rows, by: criteria)
        return groups.map(GroupedSection.init(sectionItem:rows:))
    }

}
