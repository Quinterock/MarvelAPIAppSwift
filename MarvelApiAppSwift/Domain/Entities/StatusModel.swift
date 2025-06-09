//
//  StatusModel.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

enum Status {
    case none, loading, loaded, error(error: String)
}
