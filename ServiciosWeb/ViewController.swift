import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var lblSimple: NSTextField!
    @IBOutlet weak var lblIntermediate: NSTextField!
    @IBOutlet weak var lblAdvance: NSTextField!
    @IBOutlet weak var imgStatusSimple: NSImageView!
    @IBOutlet weak var imgStatusIntermediate: NSImageView!
    @IBOutlet weak var imgStatusAdvance: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        }
    }
    
    private func simple() -> Void {
        SimpleConection.sendResponse { [weak self] (arrDtcAlbums, error) in
            if error.code == 0, let dtcAlbum: [String: Any] = arrDtcAlbums?[0] {
                print(dtcAlbum["title"] ?? "sin titulo")
                self?.lblSimple.stringValue = "On line"
                self?.imgStatusSimple.image = NSImage(named: "NSStatusAvailable")
            } else {
                self?.lblSimple.stringValue = "Off line"
                self?.imgStatusSimple.image = NSImage(named: "NSStatusUnavailable")
                print(error)
            }
        }
    }
    
    private func intermediate() -> Void {
        IntermediateConection.sendResponse { [weak self] (albums, error) in
            if error.code == 0 {
                print(albums?[0].title ?? "sin titulo")
                self?.lblIntermediate.stringValue = "On line"
                self?.imgStatusIntermediate.image = NSImage(named: "NSStatusAvailable")
            } else {
                self?.lblIntermediate.stringValue = "Off line"
                self?.imgStatusIntermediate.image = NSImage(named: "NSStatusUnavailable")
                print(error)
            }
        }
    }

    private func avanzado() -> Void {
        let headers = [
            HeadersCon(value: "application/json", key: "Content-Type")
        ]
        
        BaseConection.sendResponse(strUrl: "https://jsonplaceholder.typicode.com/albums", method: .GET, arrHeardes: headers, objBody: EmptyObj()) { [weak self] (albums: [Album]?, error) in
            if error.code == 0 {
                print(albums?[0].title ?? "sin titulo")
                self?.lblAdvance.stringValue = "On line"
                self?.imgStatusAdvance.image = NSImage(named: "NSStatusAvailable")
            } else {
                self?.lblAdvance.stringValue = "Off line"
                self?.imgStatusAdvance.image = NSImage(named: "NSStatusUnavailable")
                print(error)
            }
        }
    }

    @IBAction func initConections(_ sender: Any) {
        simple()
        intermediate()
        avanzado()
    }
    
}

