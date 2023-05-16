

import UIKit
import Lottie

public class SplashViewController: UIViewController {
    
    private var animationView: LottieAnimationView?

    public override func viewDidLoad() {
      super.viewDidLoad()

        animationView = .init(name: "splash")
         
         animationView!.frame = view.bounds
         
         // 3. Set animation content mode
         
         animationView!.contentMode = .scaleAspectFit
         
         // 4. Set animation loop mode
         
         animationView!.loopMode = .playOnce
         
         // 5. Adjust animation speed
         
         animationView!.animationSpeed = 0.5
         
         view.addSubview(animationView!)
         
         // 6. Play animation
         
         animationView!.play(){ (finished) in
                                          self.startFlutterApp()
                                      }
        }

    
    func startFlutterApp() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let flutterEngine = appDelegate.flutterEngine
        let flutterViewController =
            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        flutterViewController.modalPresentationStyle = .custom
        flutterViewController.modalTransitionStyle = .crossDissolve
        
        present(flutterViewController, animated: true, completion: nil)
        
    }
}
