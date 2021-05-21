import Foundation

class BaseConection {
    
    private let ownError: NSError = NSError(domain: "BaseConection", code: -1, userInfo: nil)
    
    public func sendResponse<T: Decodable>(strUrl: String, method: MethodCon, arrHeardes: [HeadersCon]?, handler: @escaping (_ objResp: T?, NSError) -> ()) {
        
        guard let endpoint: URL = URL(string: strUrl) else {
            return
        }
        
        var request = URLRequest(url: endpoint)
        
        arrHeardes?.forEach({ headersCon in
            request.setValue(headersCon.value, forHTTPHeaderField: headersCon.key)
        })
        
        request.httpMethod = method.rawValue
        
        /*guard let body = try? JSONEncoder().encode(objBody) else {
            return
        }*/

        //request.httpBody = body
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.sync {
                if let errorNS = error as NSError? {
                    handler(nil, errorNS)
                }
                
                guard let dataRes = data, let objRes = try? JSONDecoder().decode(T.self, from: dataRes) else {
                    handler(nil, self.ownError)
                    return
                }
                
                handler(objRes, NSError(domain: "BaseConection", code: 0, userInfo: nil))
            }
        }
        
        tarea.resume()
        
    }
    
}


struct HeadersCon {
    let value: String
    let key: String
    
    init(value: String, key: String) {
        self.value = value
        self.key = key
    }
}

enum MethodCon: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct EmptyObj: Encodable {
    init() {
    }
}
