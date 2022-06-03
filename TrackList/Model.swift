//
//  Model.swift
//  TrackList
//
// Author: Guadarrama Ortega César Alejandro
//

import UIKit

struct ResultsSearch: Codable{
    var resultCount: Int
    var results:[Track]
}

struct Track: Codable{
    var artistName: String
    var trackName: String
    var artworkUrl100: String
}


