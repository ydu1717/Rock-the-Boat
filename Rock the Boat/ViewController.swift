

import UIKit

var screenWidth  = UIScreen.main.bounds.size.width
var screenHeight = UIScreen.main.bounds.size.height


class ViewController: UIViewController {

//    private lazy var water : WarterWave = {
//        let water = WarterWave.init(frame: CGRect.init(x: screenWidth/2 - 150, y: screenHeight/2 - 200 - 50, width: 300, height: 400))
//        return water
//    }()
//
    private lazy var start : UIButton = {
        let start = UIButton.init()
        start.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        start.setTitleColor(.black, for: .normal)
        start.frame = CGRect.init(x: screenWidth/2 - 100, y: screenHeight - 75, width: 200, height: 50)
        start.addTarget(self, action: #selector(startClick), for: .touchUpInside)
        start.layer.masksToBounds = true
        start.layer.cornerRadius = 3
        start.layer.borderWidth = 1
        start.layer.borderColor = UIColor.black.cgColor
        return start
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
                    self.start.frame = CGRect.init(x: screenWidth/2 - 100, y: screenHeight - 75, width: 200, height: 50)
                    if self.view.viewWithTag(998) != nil {
                        let water1 : WarterWave = self.view.viewWithTag(998) as! WarterWave
                        water1.frame = CGRect.init(x: screenWidth/2 - 150, y: screenHeight/2 - 200 - 50, width: 300, height: 400)
                    }
                    
                }
            }
        }
    }
}

extension ViewController {
    
    func initUI() -> Void {
        view.backgroundColor = UIColor.white
        view.addSubview(self.start)
    }
    
    @objc func startClick() -> Void {

        for i in self.view.subviews
        {
            i.removeFromSuperview()
        }
        let water1 = WarterWave.init(frame: CGRect.init(x: screenWidth/2 - 150, y: screenHeight/2 - 200 - 50, width: 300, height: 400))
        water1.tag = 998
        water1.wave()
        view.addSubview(water1)
        
    }
}

