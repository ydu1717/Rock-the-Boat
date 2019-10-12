

import UIKit

var screenWidth  = UIScreen.main.bounds.size.width
var screenHeight = UIScreen.main.bounds.size.height


class ViewController: UIViewController {

    private lazy var water : WarterWave = {
        let water = WarterWave.init(frame: CGRect.init(x: screenWidth/2 - 150, y: screenHeight/2 - 200 - 50, width: 300, height: 400))
        return water
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    //MARK :
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        do {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
            {
                if screenWidth != size.width
                {
                    screenWidth  = size.width
                    screenHeight = size.height
                }
            }
        }
    }
}

extension ViewController {
    
    func initUI() -> Void {
        
        view.addSubview(water)

//        water.wave()
        
        let start = UIButton.init()
        start.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        start.setTitleColor(.label, for: .normal)
        start.frame = CGRect.init(x: screenWidth/2 - 100, y: water.frame.origin.y + water.frame.size.height + 30, width: 200, height: 50)
        start.addTarget(self, action: #selector(startClick), for: .touchUpInside)
        view.addSubview(start)
        
    }
    
    @objc func startClick() -> Void {
        water.wave()
    }
}

