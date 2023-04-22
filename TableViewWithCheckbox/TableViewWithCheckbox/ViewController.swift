//
//  ViewController.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 17/04/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = {
        MoviesViewModel()
    }()
    
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
       // descriptionModel.append(DescriptionModel(title: "Hello", isSelected: false,description: "How are you? I am fine.Thank you.will Call you later", image: UIImage(named: "images.png")))
        initViewModel()
    }
    
    func initViewModel() {
        // Get employees data
        viewModel.getMovies()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }


}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies?.tvShows?.count ?? 0//descriptionModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descTableViewCell", for: indexPath) as! descTableViewCell
        
        var data = viewModel.movies?.tvShows?[indexPath.row]
        cell.titleLabel.text = data?.name
        cell.descLabel.text = data?.permalink
        
        //let url = URL(string: (data?.imageThumbnailPath)!)
       // let data1 = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.profileImage.layer.cornerRadius = 5
        
        let url = URL(string: (data?.imageThumbnailPath)!)
        // this downloads the image asynchronously if it's not cached yet
        cell.profileImage.kf.setImage(with: url)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    
    
    
}

