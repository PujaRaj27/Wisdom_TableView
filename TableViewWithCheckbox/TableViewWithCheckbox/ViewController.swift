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
    var checkboxStates = [Int: Bool]()
    lazy var viewModel = {
        MoviesViewModel()
    }()
    private let refreshControl = UIRefreshControl()
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    var selectedIndex : IndexPath?
    
    
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
      
        initViewModel()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshMovieData(_:)), for: .valueChanged)
       
    }
    
    func initViewModel() {

        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
       self.loadMoreItemsForList()
        
        self.refreshControl.endRefreshing()
        
    }
    
    @objc private func refreshMovieData(_ sender: Any) {
        // Fetch Movie Data
        initViewModel()
    }
//
    func getListFromServer(_ pageNumber: Int){

        print("getListFromServer=>getMovies=>pageNumber=\(pageNumber)")
        viewModel.getMovies(pageNumber: currentPage)
        print("getListFromServer=>reloadData")
        self.tableView.reloadData()
        }

    func loadMoreItemsForList(){
           currentPage += 1
           getListFromServer(currentPage)
       }
    
    @IBAction func btnSelectRadioAction(_ sender: UIButton) {
        let inx = sender.tag
  
                 let tag = sender.tag
                if let checkboxState = checkboxStates[tag] {
                    checkboxStates[tag] = !checkboxState
                } else {
                    checkboxStates[tag] = true
                }
                
        let checkboxImage = checkboxStates[tag]! ? UIImage(named: "ic_Select") : UIImage(named: "ic_radioEmpty")
                sender.setImage(checkboxImage, for: .normal)
        
                   tableView.reloadData()
             
    }
    
    private var selectedMovie: Int? {
        didSet {
            tableView.reloadData()
        }
    }
       
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies?.tvShows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descTableViewCell", for: indexPath) as! descTableViewCell
        
        var data = viewModel.movies?.tvShows?[indexPath.row]
        cell.titleLabel.text = data?.name
        cell.descLabel.text = data?.permalink
        cell.profileImage.layer.cornerRadius = 5

        let url = URL(string: (data?.imageThumbnailPath)!)
        // this downloads the image asynchronously if it's not cached yet
        cell.profileImage.kf.setImage(with: url)

        cell.checkboxBtn.addTarget(self, action: #selector(btnSelectRadioAction(_:)), for: .touchUpInside)
        cell.checkboxBtn.tag = indexPath.row
        
        if let checkboxState = checkboxStates[indexPath.row] {
                   let checkboxImage = checkboxState ? UIImage(named: "check-mark") : UIImage(named: "ic_radioEmpty")
                   cell.checkboxBtn.setImage(checkboxImage, for: .normal)
               } else {
                   cell.checkboxBtn.setImage(UIImage(named: "ic_radioEmpty"), for: .normal)
               }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func updateSelectedIndex(_ index: Int) {
        selectedMovie = index
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
            if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !viewModel.isLoadingMovies){
                print("scrollViewDidScroll==true")
                viewModel.isLoadingMovies = true
                self.loadMoreItemsForList()
            }
        }


    
}

