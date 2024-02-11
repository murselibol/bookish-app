//
//  AuthorBookListVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 21.01.2024.
//

import UIKit
import SnapKit

protocol AuthorBookListVCDelegate: AnyObject {
    func configureBookListTableView()
    func constraintBookListTableView()
    func reloadBookListTableView()
    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
    func navigateBookDetailVC(id: String)
}

final class AuthorBookListVC: UIViewController {
    
    var viewModel: AuthorBookListVM!
    weak var coordinator: AuthorBookListCoordinator?
    
    private lazy var indicatorView = IndicatorView()
    private lazy var authorView: AuthorView = {
        let view = AuthorView()
        view.frame = CGRect(x: 0, y: 0, width: bookListTableView.frame.width, height: 370)
        return view
    }()
    
    private lazy var bookListTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    init(authorName: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = AuthorBookListVM(view: self, authorName: authorName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .getColor(.background)
        viewModel.viewDidLoad()
    }
    
    deinit { coordinator?.finishCoordinator() }
    
}

// MARK: - UITableViewDelegate
extension AuthorBookListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier, for: indexPath) as! BookListTableViewCell
        cell.setUIData(data: viewModel.tableCellForItem(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.tableViewWillDisplay(at: indexPath)
    }
}

// MARK: - AuthorBookListVCDelegate
extension AuthorBookListVC: AuthorBookListVCDelegate {
    func configureBookListTableView() {
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        bookListTableView.isUserInteractionEnabled = true
        bookListTableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.identifier)
        authorView.setUIData(authorName: viewModel.authorName)
        bookListTableView.tableHeaderView = authorView
    }
    
    func constraintBookListTableView() {
        view.addSubview(bookListTableView)
        bookListTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func reloadBookListTableView() {
        DispatchQueue.main.async {
            self.bookListTableView.reloadData()
        }
    }
    
    func constraintIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        updateIndicatorState(hidden: true)
    }
    
    func updateIndicatorState(hidden: Bool) {
        DispatchQueue.main.async {
            self.indicatorView.isHidden = hidden
        }
    }
    
    func navigateBookDetailVC(id: String) {
        coordinator?.navigateBookDetailVC(id: id)
    }
}

// MARK: - BookClickListener
extension AuthorBookListVC: BookClickListener {
    func onClickBook(id: String) {
        coordinator?.navigateBookDetailVC(id: id)
    }
}
