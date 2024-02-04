//
//  BookResponse.swift
//  bookish-app
//
//  Created by Mursel Elibol on 11.01.2024.
//

import Foundation

struct BookResponse: Codable {
    let kind, id, etag: String?
    let selfLink: String?
    let volumeInfo: BookInfo?
    let accessInfo: AccessInfo?
//    let saleInfo: SaleInfo?
}

// MARK: - BookInfo
struct BookInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate, description: String?
    let readingModes: ReadingModes?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let averageRating: Double?
    let ratingsCount: Int?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}


// MARK: - ReadingModes
struct ReadingModes: Codable {
    let text, image: Bool?
}

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let country, viewability: String?
    let embeddable, publicDomain: Bool?
    let epub, pdf: Epub?
    let webReaderLink: String?
}

// MARK: - Epub
struct Epub: Codable {
    let isAvailable: Bool?
}

// MARK: - SaleInfo
struct SaleInfo: Codable {
    let country, saleability: String?
    let isEbook: Bool?
    let listPrice, retailPrice: Price?
    let buyLink: String?
}

// MARK: - Price
struct Price: Codable {
    let amount: Int?
    let currencyCode: String?
}
