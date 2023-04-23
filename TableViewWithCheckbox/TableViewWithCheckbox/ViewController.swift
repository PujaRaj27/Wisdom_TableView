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
    private let refreshControl = UIRefreshControl()
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    
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
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshMovieData(_:)), for: .valueChanged)
       
    }
    
    func initViewModel() {
        // Get employees data
       // var pageNumber = viewModel.movies?.page ?? 1
//        viewModel.getMovies(pageNumber: currentPage)
       
        
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
//    func getListFromServer(){
//        viewModel.getMovies(pageNumber: currentPage)
//        //self.tableView.reloadData()
//        self.isLoadingList = false
//    }
//
//       func loadMoreItemsForList(){
//          // viewModel.movies?.page =  (viewModel.movies?.page)! + 1//currentPage += 1
//            currentPage += 1
//           getListFromServer()
//       }
    
    func getListFromServer(_ pageNumber: Int){
        
            print("getListFromServer=>getMovies=>pageNumber=\(pageNumber)")
            viewModel.getMovies(pageNumber: currentPage)
//        self.isLoadingList = viewModel.isLoadingMovies
        print("getListFromServer=>reloadData")
            self.tableView.reloadData()
        }
    
    func loadMoreItemsForList(){
           currentPage += 1
           getListFromServer(currentPage)
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
        cell.profileImage.layer.cornerRadius = 5
        
        let url = URL(string: (data?.imageThumbnailPath)!)
        // this downloads the image asynchronously if it's not cached yet
        cell.profileImage.kf.setImage(with: url)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll=>contentOffset.y=\(scrollView.contentOffset.y)")
        print("scrollViewDidScroll=>frame.size.height=\(scrollView.frame.size.height)")
        print("scrollViewDidScroll=>contentSize.height=\(scrollView.contentSize.height)")
        print("scrollViewDidScroll=>viewModel.isLoadingMovies=\(viewModel.isLoadingMovies)")
            if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !viewModel.isLoadingMovies){
                print("scrollViewDidScroll==true")
                viewModel.isLoadingMovies = true
                self.loadMoreItemsForList()
            }
        }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollView.contentOffset.y==\(scrollView.contentOffset.y)")
//        print("scrollView.frame.size.height==\(scrollView.frame.size.height)")
//        print("scrollView.contentSize.height==\(scrollView.contentSize.height)")
//        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
//            print("scrollViewDidScroll:True")
//                self.isLoadingList = true
//                self.loadMoreItemsForList()
//
//            }
//        }
    

    
    
}

