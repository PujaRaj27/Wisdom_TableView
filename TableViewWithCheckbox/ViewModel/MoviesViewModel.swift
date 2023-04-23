//
//  MoviesViewModel.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 22/04/23.
//

import Foundation


class MoviesViewModel: NSObject {
    private var movieService: MoviesServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var isLoadingMovies: Bool = false
    
    var movies : Movies?
    
    var movieCellViewModels = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(movieService: MoviesServiceProtocol = MoviesService()) {
        self.movieService = movieService
    }
    
    func getMovies(pageNumber : Int) {
        self.isLoadingMovies = true
        movieService.getMovies(pageNumber: pageNumber) { success, model, error in
            if success, let movies = model {
                self.fetchData(movies: movies ,pageNumber: pageNumber)
                
            } else {
                self.isLoadingMovies = false
                print("Error :ViewModel==\(String(describing: error))")
            }
        }
    }
    
    func fetchData(movies: Movies,pageNumber : Int) {
        self.movies = movies
        self.movies?.page = pageNumber
        var vms = [MovieCellViewModel]()

        vms.append(createCellModel(movie: self.movies!))

        movieCellViewModels = vms
        
        self.isLoadingMovies = false
        
    }
    
    func createCellModel(movie: MoviesModel) -> MovieCellViewModel {
      
        let page = movie.page
        let total = movie.total
        let pages = movie.pages
        let tv_shows = movie.tvShows
     
        
        return  MovieCellViewModel(total: total, tvShows: tv_shows, pages: pages, page: page)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return movieCellViewModels[indexPath.row]
    }
}
