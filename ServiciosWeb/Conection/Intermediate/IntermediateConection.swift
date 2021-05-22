import Foundation

class IntermediateConection {
    
    private static let ownError: NSError = NSError(domain: "SimpleConection", code: -1, userInfo: nil)
    
    public static func sendResponse(handler: @escaping (_ objResp: [Album]?, NSError) -> ()) {
        
        let strUrl = "https://jsonplaceholder.typicode.com/albums"
        
        guard let endpoint: URL = URL(string: strUrl) else {
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.sync {
                if let errorNS = error as NSError? {
                    handler(nil, errorNS)
                }
                
                guard let dataRes = data, let objRes = try? JSONDecoder().decode([Album].self, from: dataRes) else {
                    handler(nil, self.ownError)
                    return
                }
                
                handler(objRes, NSError(domain: "BaseConection", code: 0, userInfo: nil))
            }
        }
        
        tarea.resume()
        
        
    }
    
}
