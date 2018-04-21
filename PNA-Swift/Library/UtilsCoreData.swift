import UIKit
import CoreData
class UtilsCoreData: NSObject {
    static let sharedInstance = UtilsCoreData()
    override init() {
    }
    func addStudent(_ dic:NSMutableDictionary) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let newStudent = NSManagedObject(entity: entity!, insertInto: context)
        for (key, value) in dic {
            newStudent.setValue(value, forKey: key as! String)
        }
        do {
            try context.save()
        } catch {
            print("Failed addStudent")
        }
    }
    func deleteAllStudent(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            print("Failed deleteAllStudent")
        }
    }
    func deleteStudent(_ id: NSInteger){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let predicate = NSPredicate(format: "id = \(id)")
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            print("Failed deleteStudent")
        }
    }
    func isExistStudent(_ name: NSInteger, _ gender:Bool, _ date_of_birth:Date) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
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
            print("Failed isExistStudent")
        }
        return false
    }
    func countStudent() -> NSInteger {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            let result = try context.fetch(request)
           return result.count
        } catch {
            print("Failed countStudent")
        }
        return 0
    }
    func queryAllStudent() -> [Any]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        request.propertiesToFetch = ["name"]
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        request.returnsDistinctResults = true
        let sortName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortName]
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Failed queryAllStudent")
        }
        return []
    }
    func updateStudent(_ id: NSInteger, _ dic:NSMutableDictionary){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
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
            print("Failed updateStudent")
        }
    }
}
