import UIKit
import CoreData
class UtilsCoreData: NSObject {
    static let sharedInstance = UtilsCoreData()
    override init() {
    }
    func add(_ entityName:String, _ dic:NSMutableDictionary) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newStudent = NSManagedObject(entity: entity!, insertInto: context)
        for (key, value) in dic {
            newStudent.setValue(value, forKey: key as! String)
        }
        do {
            try context.save()
        } catch {
            UtilsLog.log(self, message: "Failed add: "+entityName)
        }
    }
    func delete(_ entityName:String, _ id: NSInteger){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "id = \(id)")
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            UtilsLog.log(self, message: "Failed delete: "+entityName)
        }
    }
    func deleteAll(_ entityName:String){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            UtilsLog.log(self, message: "Failed deleteAll: "+entityName)
        }
    }
    func isExist(_ entityName:String, _ name: NSInteger, _ gender:Bool, _ date_of_birth:Date) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate1 = NSPredicate(format: "name = \(name)")
        let predicate2 = NSPredicate(format: "gender = \(gender)")
        let predicate3 = NSPredicate(format: "date_of_birth = \(date_of_birth)")
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                return true
            }
        } catch {
            UtilsLog.log(self, message: "Failed isExist: "+entityName)
        }
        return false
    }
    func countRows(_ entityName:String) -> NSInteger {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try context.fetch(request)
            return result.count
        } catch {
            UtilsLog.log(self, message: "Failed countRows: "+entityName)
        }
        return 0
    }
    func queryAll(_ entityName:String) -> [Any]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.propertiesToFetch = ["name"]
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        request.returnsDistinctResults = true
        let sortName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortName]
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            UtilsLog.log(self, message: "Failed queryAll: "+entityName)
        }
        return []
    }
    func update(_ entityName:String, _ id: NSInteger, _ dic:NSMutableDictionary){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "id = \(id)")
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        do {
            let result = try context.fetch(request)
            if result.count == 1{
                let objectUpdate = result[0] as! NSManagedObject
                for (key, value) in dic {
                    objectUpdate.setValue(value, forKey: key as! String)
                }
                do{
                    try context.save()
                }
                catch{
                    print(error)
                }
            }
        } catch {
            UtilsLog.log(self, message: "Failed update: "+entityName)
        }
    }
}
