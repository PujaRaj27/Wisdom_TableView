//
//  MovieService.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 22/04/23.
//

import Foundation


protocol MoviesServiceProtocol {
    func getMovies(pageNumber: Int,completion: @escaping (_ success: Bool, _ results: Movies?, _ error: String?) -> ())
}

class MoviesService: MoviesServiceProtocol {

   
    func getMovies(pageNumber : Int,completion: @escaping (Bool, Movies?, String?) -> ()) {

        HttpRequestHelper().GET(url: "https://www.episodate.com/api/most-popular?", params: ["page": "\(pageNumber)"], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let str = String(decoding: data!, as: UTF8.self)
                    print("str ==\(str)")
                    let jsonData = Data(str.utf8)
                    let model = try JSONDecoder().decode(Movies.self, from: data!)
                    print("model==\(model)")
                    completion(true, model, nil)
                } catch {
                    print(error.localizedDescription)
                    print("error==\(error.localizedDescription)")
                    completion(false, nil, "Error: Trying to parse Movies to model")
                }
            } else {
                completion(false, nil, "Error: Movies GET Request failed")
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
