//
//  Movie+CoreDataProperties.swift
//  MyMovieList
//
//  Created by 장창순 on 2016. 2. 18..
//  Copyright © 2016년 Swiftbook. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var image: NSData?
    @NSManaged var title: String?
    @NSManaged var genre: String?
    @NSManaged var url: String?

}
