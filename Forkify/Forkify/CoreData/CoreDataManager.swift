//
//  CoreDataManager.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit
import CoreData

class CoreDataManager{
    
    // MARK:- Properties
    public static var shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    var searchHistory = [SearchHistory]()
    
    private init(){
        privateMOC.parent = context
    }
    
    
    // MARK:- Fetch SearchHistory
    func fetchSearchHistory() {
        do {
            self.searchHistory =  try context.fetch(SearchHistory.fetchRequest())
            if searchHistory.count > 10 {
                self.context.delete(searchHistory.first ?? SearchHistory())
                self.save()
            }
        }
        catch let error {
            print("Fetch Records error :", error)
        }
    }
    
    
    // MARK:- Add Search
    public func addSearch(searchText:String) {
        privateMOC.performAndWait {
            let newSearch = SearchHistory(context: privateMOC)
            newSearch.searchText = searchText
            saveContext(forContext: privateMOC)
        }
        self.save()
    }

    
    // MARK:- Save Search
    func save() {
        do {
            try context.save()
        }
        catch let error {
            print("Save Search History error :", error)
        }
        fetchSearchHistory()
    }
    
    func saveContext(forContext context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait{
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    print("Error when saving !!! \(nserror.localizedDescription)")
                    print("Callstack :")
                    for symbol: String in Thread.callStackSymbols {
                        print(" > \(symbol)")
                    }
                }
            }
        }
    }
    
    // MARK:- Get All Search History
    func getAllSearchHistory() -> [String] {
        var result = [String]()
        
        fetchSearchHistory()
        searchHistory.forEach { search in
            result.append(search.searchText ?? "")
        }
        return result
    }
    
}
