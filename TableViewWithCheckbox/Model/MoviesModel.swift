//
//  MoviesModel.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 22/04/23.
//

import Foundation

typealias Movies = MoviesModel

// MARK: - Employee
struct MoviesModel: Codable {
    enum CodingKeys: String, CodingKey {
      case total = "total"
      case tvShows = "tv_shows"
      case pages = "pages"
      case page = "page"
    }

    var total: String?
    var tvShows: [TvShows]?
    var pages: Int?
    var page: Int?



    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      total = try container.decodeIfPresent(String.self, forKey: .total)
      tvShows = try container.decodeIfPresent([TvShows].self, forKey: .tvShows)
      pages = try container.decodeIfPresent(Int.self, forKey: .pages)
      page = try container.decodeIfPresent(Int.self, forKey: .page)
    }
}
