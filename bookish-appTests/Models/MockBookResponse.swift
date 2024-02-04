//
//  MockBookResponse.swift
//  bookish-appTests
//
//  Created by Mursel Elibol on 3.02.2024.
//

@testable import bookish_app

struct MockBookResponse {
    
    static func executeBook() -> BookResponse {
        generateMockData(id: 1)
    }
            
    static func executeBooks(count: Int = 5) -> [BookResponse] {
        (1...count).map(generateMockData)
    }
    
    
    static func generateMockData(id: Int) -> BookResponse {
        let imageLinks = ImageLinks(smallThumbnail: "https://example.com/small_thumbnail.jpg", thumbnail: "https://example.com/thumbnail.jpg")
        let readingModes = ReadingModes(text: true, image: true)
        let epub = Epub(isAvailable: true)
        
        let bookInfo = BookInfo(
            title: "Book \(id)",
            authors: ["John Doe"],
            publisher: "Publisher ABC",
            publishedDate: "2023-01-01",
            description: "This is an example book description.",
            readingModes: readingModes,
            pageCount: 200,
            printType: "Paperback",
            categories: ["Fiction", "Mystery"],
            averageRating: 4.5,
            ratingsCount: 100,
            imageLinks: imageLinks,
            language: "en",
            previewLink: "https://example.com/preview",
            infoLink: "https://example.com/info",
            canonicalVolumeLink: "https://example.com/canonical"
        )
        
        let accessInfo = AccessInfo(
            country: "US",
            viewability: "PARTIAL",
            embeddable: true,
            publicDomain: false,
            epub: epub,
            pdf: nil,
            webReaderLink: "https://example.com/web_reader"
        )
        
        return BookResponse(
            kind: "books#volume",
            id: String(id),
            etag: "zQY50Z2YkPs",
            selfLink: "https://example.com/self_link",
            volumeInfo: bookInfo,
            accessInfo: accessInfo
        )
    }
}
