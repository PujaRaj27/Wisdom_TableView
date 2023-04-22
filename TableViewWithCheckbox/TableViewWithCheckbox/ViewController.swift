//
//  ViewController.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 17/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var descriptionModel = [DescriptionModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        // Do any additional setup after loading the view.
    }
    func config(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "descTableViewCell", bundle: nil), forCellReuseIdentifier: "descTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        descriptionModel.append(DescriptionModel(title: "Hello", isSelected: false,description: "How are you? I am fine.Thank you.will Call you later", image: UIImage(named: "images.png")))
        
    }


}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptionModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descTableViewCell", for: indexPath) as! descTableViewCell
        
        var temp = descriptionModel[indexPath.row]
        cell.titleLabel.text = temp.title
        cell.descLabel.text = temp.description
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    
    
    
}

