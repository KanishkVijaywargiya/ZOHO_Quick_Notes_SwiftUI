//
//  NoteEntity+CoreDataProperties.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 15/09/22.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var body: String
    @NSManaged public var title: String
    @NSManaged public var createdTime: Int16
    @NSManaged public var id: UUID
    @NSManaged public var imageURL: Data?

}

extension NoteEntity : Identifiable {

}
