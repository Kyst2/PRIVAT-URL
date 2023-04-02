import Foundation

extension DateFormatter {
    static var shared = DateFormatter()
    
    func getDateCustom(strDate: String, withFormat format: String) -> Date? {
        self.dateFormat = format
        
        return self.date(from: strDate)
    }
}
