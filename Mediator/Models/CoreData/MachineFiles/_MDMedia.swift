// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MDMedia.swift instead.

import Foundation
import CoreData

public enum MDMediaAttributes: String {
    case filePath = "filePath"
    case thumbPath = "thumbPath"
    case title = "title"
    case type = "type"
}

open class _MDMedia: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "MDMedia"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _MDMedia.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var filePath: String?

    @NSManaged open
    var thumbPath: String?

    @NSManaged open
    var title: String?

    @NSManaged open
    var type: NSNumber?

    // MARK: - Relationships

}

