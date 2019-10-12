

import UIKit

var screenWidth  = UIScreen.main.bounds.size.width
var screenHeight = UIScreen.main.bounds.size.height


class ViewController: UIViewController {

 
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
        
        let water = WarterWave.init(frame: CGRect.init(x: screenWidth/2 - 150, y: screenHeight/2 - 200, width: 300, height: 400))
        water.backgroundColor = .gray
        view.addSubview(water)
        
    }
}

