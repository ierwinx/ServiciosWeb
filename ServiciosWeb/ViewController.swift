import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let headers = [
            HeadersCon(value: "application/json", key: "Content-Type")
        ]
        
        let servicio = BaseConection()
        servicio.sendResponse(strUrl: "https://jsonplaceholder.typicode.com/albums", method: .GET, arrHeardes: headers) { (album: [Album]?, error) in
            if error.code == 0 {
                print(album!)
            } else {
                print(error)
            }
            
        }
        
    }

    override var representedObject: Any? {
        didSet {
        }
    }


}

