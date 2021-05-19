//
//  SearchHistory+CoreDataProperties.swift
//  
//
//  Created by Islam Elgaafary on 19/05/2021.
//
//

import Foundation
import CoreData


extension SearchHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistory> {
        return NSFetchRequest<SearchHistory>(entityName: "SearchHistory")
    }

    @NSManaged public var searchText: String?

}
