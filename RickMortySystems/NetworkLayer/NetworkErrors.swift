//
//  NetworkErrors.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation

enum NetworkErrors: Error {
case notNetworkAvailable
case incorrectURL
case unknownError(error: String)
}
