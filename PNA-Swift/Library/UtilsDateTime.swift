import UIKit
class UtilsDateTime: NSObject {
    static let sharedInstance = UtilsDateTime()
    override fileprivate init() {
    }
    func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        //var gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "H:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
    
    func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    func daySuffix(from date: Date) -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    // Format: May 01st, 2018
    // Input style: yyyy-MM-dd
    func toFullTextDateStyle(inputString: String) -> String {
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = gregorian! as Calendar
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: inputString)
        
        let suffix = self.daySuffix(from: date!)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateFormatter.timeZone = TimeZone.current
        var timeStamp = dateFormatter.string(from: date!)
        timeStamp = timeStamp.replacingOccurrences(of: ",", with: "\(suffix),")
        
        return timeStamp
    }
    
    func getCurrentTime() -> String {
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mma"
        formatter.timeZone = TimeZone.current
        formatter.calendar = gregorian! as Calendar
        
        var myString = formatter.string(from: Date())
        myString = myString.replacingOccurrences(of: " ", with: " at ")
        
        return myString
    }
    
    func convertToAppStyleDate(string: String) -> String {
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = gregorian! as Calendar
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: string)
        
        // To convert the date into an HH:mm format
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone.current
        var final = dateFormatter.string(from: date!)
        //created_at = created_at?.replacingOccurrences(of: "-", with: "/")
        final = final.replacingOccurrences(of: " ", with: " at ")
        return final
    }
}
