//
//  TvShows.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 22/04/23.
//

import Foundation


struct TvShows: Codable {

  enum CodingKeys: String, CodingKey {
      
    case startDate = "start_date"
    case name = "name"
    case imageThumbnailPath = "image_thumbnail_path"
    case country = "country"
    case status = "status"

    case network = "network"
    case permalink = "permalink"
//    case isSelected = "isSelected"
    case id = "id"
  }

  var id : Int?
  var startDate: String?
  var imageThumbnailPath: String?
  var country: String?
  var status: String?
  var name: String?
  var network: String?
  var permalink: String?
  var isSelected: Bool = false



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decodeIfPresent(Int.self, forKey: .id)
      startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
    imageThumbnailPath = try container.decodeIfPresent(String.self, forKey: .imageThumbnailPath)
    country = try container.decodeIfPresent(String.self, forKey: .country)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    network = try container.decodeIfPresent(String.self, forKey: .network)
    permalink = try container.decodeIfPresent(String.self, forKey: .permalink)
    //isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected)!
  }

}
