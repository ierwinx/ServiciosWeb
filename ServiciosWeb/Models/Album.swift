import Foundation

struct Album: Decodable {
    
    let userId: Int
    let id: Int
    let title: String
    
    init(userId: Int, id: Int, title: String) {
        self.userId = userId
        self.id = id
        self.title = title
    }
    
}
