//
//  BookDetailVM.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import Foundation

protocol BookDetailVMDelegate {
    var authorName: String { get }
    func viewDidLoad()
    func onClickReadMore() -> (line: Int, text: String, image: String)
}

final class BookDetailVM {
    
    weak var view: BookDetailVCDelegate?
    private let bookService: BookService
    var bookId: String = ""
    var book: BookResponse?
    var isOpenReadMore: Bool = false

    
    init(view: BookDetailVCDelegate?, id: String, bookService: BookService = BookService.shared) {
        self.view = view
        self.bookId = id
        self.bookService = bookService
    }
    
    // MARK: - HTTP Requests
    private func getBook(id: String, queryItems: [URLQueryItem] = []) {
        view?.updateIndicatorState(hidden: false)
        bookService.getBook(id: id, queryItems: queryItems) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                book = data
                updateUIData(data: data)
                view?.updateIndicatorState(hidden: true)
            case .failure(let error):
                print(error)
                view?.updateIndicatorState(hidden: true)
                break
            }
        }
    }
    
    func updateUIData(data: BookResponse) {
        let bookInfo = book?.volumeInfo
        let data = BookDetailArguments(
            title: bookInfo?.title ?? "",
            thumbnail: bookInfo?.imageLinks?.thumbnail ?? "",
            author: bookInfo?.authors?.first ?? "-",
            ratingCount: "\(bookInfo?.ratingsCount ?? 0) Ratings",
            ratingAvarage: "\(bookInfo?.averageRating ?? 0)",
            category: bookInfo?.categories?.first ?? "-",
            page: "\(bookInfo?.pageCount ?? 0)",
            description: bookInfo?.description?.htmlToString() ?? "-"
        )
        view?.setData(args: data)
    }
}

extension BookDetailVM: BookDetailVMDelegate {
    var authorName: String {
        book?.volumeInfo?.authors?.first ?? ""
    }
    
    func viewDidLoad() {
        view?.constraintUI()
        view?.constraintIndicatorView()
        getBook(id: bookId)
    }
    
    func onClickReadMore() -> (line: Int, text: String, image: String) {
        self.isOpenReadMore.toggle()
        return isOpenReadMore ? (0, "Less more", "chevron.up") : (4, "Read more", "chevron.down")
    }
}
