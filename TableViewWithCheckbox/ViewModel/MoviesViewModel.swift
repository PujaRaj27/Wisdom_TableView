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
    
    var movies : Movies?
    
    var movieCellViewModels = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(movieService: MoviesServiceProtocol = MoviesService()) {
        self.movieService = movieService
    }
    
    func getMovies() {
        movieService.getMovies { success, model, error in
            if success, let movies = model {
                self.fetchData(movies: movies)
            } else {
                print("Error :ViewModel==\(String(describing: error))")//(error!)
            }
        }
    }
    
    func fetchData(movies: Movies) {
        self.movies = movies // Cache
        var vms = [MovieCellViewModel]()

        vms.append(createCellModel(movie: self.movies!))

        movieCellViewModels = vms
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
