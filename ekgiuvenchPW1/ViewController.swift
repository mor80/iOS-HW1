import UIKit

class ViewController: UIViewController {
    // MARK: Constants
    struct constants {
        static let minCornerRadius: CGFloat = 0;
        static let maxCornerRadius: CGFloat = 25;
    }
    
    @IBOutlet var tshirt: [UIView]!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        var colorsViews = getUniqueColors(size: views.count)
        let colorTshirt = getUniqueColors(size: 1)
        button.isEnabled = false
        
        UIView.animate(withDuration: 2.0,
                       animations: {
            self.views.forEach { view in
                view.layer.cornerRadius = .random(in: constants.minCornerRadius...constants.maxCornerRadius)
                view.backgroundColor = colorsViews.popFirst()
            }
            
            self.tshirt.forEach { part in
                part.backgroundColor = colorTshirt.first
            }
        }, completion: { [weak self] _ in
            self?.button.isEnabled = true})
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Unique colors
    func getUniqueColors(size: Int) -> Set<UIColor> {
        var uniqueColors = Set<UIColor>()
        uniqueColors.reserveCapacity(size)
        
        while uniqueColors.count < size {
            var hexCol = "#"
            for _ in 0...2 {
                hexCol += String(format:"%02X", Int.random(in: 0...255))
            }
            
            if let color = UIColor(hexColor: hexCol) {
                uniqueColors.insert(color)
            }
            
            print(hexCol)
        }
        
        return uniqueColors
    }
}

// MARK: UIColor hex
extension UIColor {
    public convenience init?(hexColor: String) {
        if (hexColor.hasPrefix("#") && hexColor.count == 7) {
            let start = hexColor.index(hexColor.startIndex, offsetBy: 1)
            let hex = String(hexColor[start...])
            
            let r = Int(hex[hex.index(hex.startIndex, offsetBy: 0)..<hex.index(hex.startIndex, offsetBy: 2)], radix: 16)
            let g = Int(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)], radix: 16)
            let b = Int(hex[hex.index(hex.startIndex, offsetBy: 4)..<hex.index(hex.startIndex, offsetBy: 6)], radix: 16)
            
            print(r!, g!, b!)
            
            self.init(red: CGFloat(r!) / 255, green: CGFloat(g!) / 255, blue: CGFloat(b!) / 255, alpha: 1)
            return
        }
        
        return nil
    }
}
