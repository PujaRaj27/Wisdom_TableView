//
//  CustomLaunchScreen.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 17/04/23.
//

import UIKit

class CustomLaunchScreen: UIViewController {
    var splashTimer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(splashTimerForLoadingScreen), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    
    @objc func splashTimerForLoadingScreen(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
