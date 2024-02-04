//
//  HomeVMTests.swift
//  bookish-appTests
//
//  Created by Mursel Elibol on 2.02.2024.
//

import XCTest
@testable import bookish_app

final class HomeVMTests: XCTestCase {
    private var viewModel: HomeVM!
    private var view: MockHomeVC!
    private var bookService: MockBookService!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        bookService = .init()
        viewModel = .init(view: view, bookService: bookService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_numberOfSections_ReturnSectionsCount() {
        XCTAssertEqual(viewModel.numberOfSections, 5)
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedconfigureCollectionViewLayout)
        XCTAssertFalse(view.invokedConfigureCollectionView)
        XCTAssertFalse(view.invokedConstraintCollectionView)
        XCTAssertFalse(view.invokedConstraintIndicatorView)
        XCTAssertFalse(bookService.invokedGetBooksByCategory)
        XCTAssertFalse(view.invokedStartLoading)
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertFalse(view.invokedStopLoading)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedconfigureCollectionViewLayoutCount, 1)
        XCTAssertEqual(view.invokedConfigureCollectionViewCount, 1)
        XCTAssertEqual(view.invokedConstraintCollectionViewCount, 1)
        XCTAssertEqual(view.invokedConstraintIndicatorViewCount, 1)
        XCTAssertEqual(bookService.invokedGetBooksByCategoryCount, 4)
        XCTAssertEqual(view.invokedStartLoadingCount, 4)
        XCTAssertEqual(view.invokedReloadDataCount, 4)
        XCTAssertEqual(view.invokedStopLoadingCount, 4)
        
    }
    
    func test_getLayoutSectionByIndex_WithIndex_ReturnLayoutSection() {
        let layoutSection1 = viewModel.getLayoutSectionByIndex(index: 0)
        let layoutSection2 = viewModel.getLayoutSectionByIndex(index: 1)
        let layoutSection3 = viewModel.getLayoutSectionByIndex(index: 2)
        let layoutSection4 = viewModel.getLayoutSectionByIndex(index: 3)
        let layoutSection5 = viewModel.getLayoutSectionByIndex(index: 4)
        
        XCTAssertNotNil(layoutSection1)
        XCTAssertNotNil(layoutSection2)
        XCTAssertNotNil(layoutSection3)
        XCTAssertNotNil(layoutSection4)
        XCTAssertNotNil(layoutSection5)
    }
    
    func test_numberOfItemsInSection_WithFirstIndex_ReturnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 0), 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 0), 5)
    }
    
    func test_numberOfItemsInSection_WithSecondIndex_ReturnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 1), CATEGORY_SECTION_ITEMS.count)
    }
    
    func test_numberOfItemsInSection_WithThirdIndex_ReturnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 2), 1)
    }
    
    func test_numberOfItemsInSection_WithFourthIndex_ReturnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 3), 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 3), 5)
    }
    
    func test_numberOfItemsInSection_WithFifthIndex_ReturnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 4), 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(index: 4), 5)
    }
    
    func test_popularCellForItem_WithFirstIndex_ReturnPopularSectionArguments() {
        let books = MockBookResponse.executeBooks()
        viewModel.viewDidLoad()
        
        let result = viewModel.popularCellForItem(at: .init(item: 0, section: 0))
        
        XCTAssertEqual(result.id, books[0].id)
        XCTAssertEqual(result.thumbnailUrl, books[0].volumeInfo?.imageLinks?.smallThumbnail)
        XCTAssertEqual(result.title, books[0].volumeInfo?.title)
    }
    
    func test_categoryCellForItem_WithFirstIndex_ReturnPopularSectionArguments() {
        let categories = CATEGORY_SECTION_ITEMS
        
        let result = viewModel.categoryCellForItem(at: .init(item: 0, section: 0))
        
        XCTAssertEqual(result.name, categories[0].name)
        XCTAssertEqual(result.type, categories[0].type)
        XCTAssertEqual(result.color, categories[0].color)
    }
    
    func test_bookCellForItem_ReturnBookSectionArguments() {
        let book = MockBookResponse.executeBook()
        viewModel.viewDidLoad()
        
        let result = viewModel.bookCellForItem()
        
        XCTAssertEqual(result.id, book.id)
        XCTAssertEqual(result.thumbnailUrl, book.volumeInfo?.imageLinks?.smallThumbnail)
        XCTAssertEqual(result.title, book.volumeInfo?.title)
        XCTAssertEqual(result.description, book.volumeInfo?.description)
    }
    
    func test_risingCellForItem_WithFirstIndex_ReturnPopularSectionArguments() {
        let books = MockBookResponse.executeBooks()
        let indexPathItem = 0
        viewModel.viewDidLoad()
        
        let result = viewModel.risingCellForItem(at: .init(item: indexPathItem, section: 0))
        
        XCTAssertEqual(result.id, books[0].id)
        XCTAssertEqual(result.thumbnailUrl, books[0].volumeInfo?.imageLinks?.smallThumbnail)
        XCTAssertEqual(result.rank, String(indexPathItem+1))
        XCTAssertEqual(result.title, books[0].volumeInfo?.title)
        XCTAssertEqual(result.author, books[0].volumeInfo?.authors?.first)
    }
    
    func test_discoverCellForItem_WithFirstIndex_ReturnPopularSectionArguments() {
        let books = MockBookResponse.executeBooks()
        viewModel.viewDidLoad()
        
        let result = viewModel.discoverCellForItem(at: .init(item: 0, section: 0))
        
        XCTAssertEqual(result.id, books[0].id)
        XCTAssertEqual(result.thumbnailUrl, books[0].volumeInfo?.imageLinks?.smallThumbnail)
        XCTAssertEqual(result.title, books[0].volumeInfo?.title)
        XCTAssertEqual(result.author, books[0].volumeInfo?.authors?.first)
        XCTAssertEqual(result.description, books[0].volumeInfo?.description)
    }
    
    func test_getHeaderItemBySection_WithFirstIndex_ReturnTitleCollectionReuseViewArguments() {
        let index = 0
        let expect = TitleCollectionReuseViewArguments(title: HomeSectionType.popular.sectionTitle, sectionIndex: index, hiddenSeeMore: false)
        
        let result = viewModel.getHeaderItemBySection(index: index)
        
        XCTAssertEqual(result?.title, expect.title)
        XCTAssertEqual(result?.sectionIndex, expect.sectionIndex)
        XCTAssertEqual(result?.hiddenSeeMore, expect.hiddenSeeMore)
    }
    
    func test_getHeaderItemBySection_WithSecondIndex_ReturnTitleCollectionReuseViewArguments() {
        let index = 1
        
        let result = viewModel.getHeaderItemBySection(index: index)
        
        XCTAssertNil(result)
    }
    
    func test_getHeaderItemBySection_WithThirdIndex_ReturnTitleCollectionReuseViewArguments() {
        let index = 2
        let expect = TitleCollectionReuseViewArguments(title: HomeSectionType.book.sectionTitle, sectionIndex: index, hiddenSeeMore: true)
        
        let result = viewModel.getHeaderItemBySection(index: index)
        
        XCTAssertEqual(result?.title, expect.title)
        XCTAssertEqual(result?.sectionIndex, expect.sectionIndex)
        XCTAssertEqual(result?.hiddenSeeMore, expect.hiddenSeeMore)
    }
    
    func test_getHeaderItemBySection_WithFourthIndex_ReturnTitleCollectionReuseViewArguments() {
        let index = 3
        let expect = TitleCollectionReuseViewArguments(title: HomeSectionType.rising.sectionTitle, sectionIndex: index, hiddenSeeMore: false)
        
        let result = viewModel.getHeaderItemBySection(index: index)
        
        XCTAssertEqual(result?.title, expect.title)
        XCTAssertEqual(result?.sectionIndex, expect.sectionIndex)
        XCTAssertEqual(result?.hiddenSeeMore, expect.hiddenSeeMore)
    }
    
    func test_getHeaderItemBySection_WithFifthIndex_ReturnTitleCollectionReuseViewArguments() {
        let index = 4
        let expect = TitleCollectionReuseViewArguments(title: HomeSectionType.discover.sectionTitle, sectionIndex: index, hiddenSeeMore: false)
        
        let result = viewModel.getHeaderItemBySection(index: index)
        
        XCTAssertEqual(result?.title, expect.title)
        XCTAssertEqual(result?.sectionIndex, expect.sectionIndex)
        XCTAssertEqual(result?.hiddenSeeMore, expect.hiddenSeeMore)
    }
    
    func test_getListVCArgumentsBySection_WithFirstIndex_ReturnArguments() {
        let index = 0
        
        let result = viewModel.getListVCArgumentsBySection(index: index)
        
        XCTAssertEqual(result.title, HomeSectionType.popular.sectionTitle)
        XCTAssertEqual(result.category, HomeSectionType.popular.sectionCategory)
    }
    
    func test_getListVCArgumentsBySection_WithSecondIndex_ReturnArguments() {
        let index = 1
        
        let result = viewModel.getListVCArgumentsBySection(index: index)
        
        XCTAssertEqual(result.title, HomeSectionType.category.sectionTitle)
        XCTAssertEqual(result.category, HomeSectionType.category.sectionCategory)
    }
    
    func test_getListVCArgumentsBySection_WithThirdIndex_ReturnArguments() {
        let index = 2
        
        let result = viewModel.getListVCArgumentsBySection(index: index)
        
        XCTAssertEqual(result.title, HomeSectionType.book.sectionTitle)
        XCTAssertEqual(result.category, HomeSectionType.book.sectionCategory)
    }
    
    func test_getListVCArgumentsBySection_WithFourthIndex_ReturnArguments() {
        let index = 3
        
        let result = viewModel.getListVCArgumentsBySection(index: index)
        
        XCTAssertEqual(result.title, HomeSectionType.rising.sectionTitle)
        XCTAssertEqual(result.category, HomeSectionType.rising.sectionCategory)
    }
    
    func test_getListVCArgumentsBySection_WithFifthIndex_ReturnArguments() {
        let index = 4
        
        let result = viewModel.getListVCArgumentsBySection(index: index)
        
        XCTAssertEqual(result.title, HomeSectionType.discover.sectionTitle)
        XCTAssertEqual(result.category, HomeSectionType.discover.sectionCategory)
    }
}
