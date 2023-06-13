//
//  NetworkError.swift
//  Gestidogs
//
//  Created by Mathieu CHAMBAUD on 07/06/2023.
//

import Foundation

class NetworkError {
    static let badUrl: NSError = NSError(domain: "Bad URL", code: 400)
    static let noResponse: NSError = NSError(domain: "No data to return", code: 400)
    static let errorParsingBody: NSError = NSError(domain: "Error when parsing body", code: 400)
}

enum CustomError: String, Error {
    case authorize = "Unable to authenticate user. An error occured during authorization, please check your connection and try again."
    case unavailableServer = "Server is unavailable"
}
