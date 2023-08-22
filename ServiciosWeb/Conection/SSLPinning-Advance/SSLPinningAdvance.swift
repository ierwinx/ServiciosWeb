import Foundation

class SSLPinningAdvance: NSObject {
    
    private let ownError: NSError = NSError(domain: "SSLPinningAdvance", code: -1, userInfo: nil)
    
    func sendResponse(handler: @escaping (_ objResp: [Album]?, NSError) -> ()) {
        
        let strUrl = "https://jsonplaceholder.typicode.com/albums"
        
        guard let endpoint: URL = URL(string: strUrl) else { return }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let session: URLSession = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
        
        
        let tarea = session.dataTask(with: request) { data, response, error in
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

extension SSLPinningAdvance: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust, let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
            
        let policy = NSMutableArray()
        policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        
        let bServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
        let remoteCertificate: NSData = SecCertificateCopyData(certificate)
        let pathCertificate = Bundle.main.path(forResource: "typicode.com", ofType: "cer") ?? ""
        
        guard let localCertificate = NSData(contentsOfFile: pathCertificate) as? Data else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        if bServerTrusted, remoteCertificate.isEqual(to: localCertificate) {
            print("Servidor confiable")
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            print("SSL pinning")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
        
    }
    
}
