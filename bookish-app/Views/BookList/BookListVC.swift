//
//  BookListVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import UIKit
import SnapKit

protocol BookListVCDelegate: AnyObject {
    func configureTableView()
    func constraintTableView()
    func reloadTableView()
    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
    func navigateBookDetailVC(id: String)
}

final class BookListVC: UIViewController {
    
    var viewModel: BookListVM!
    weak var coordinator: BookListCoordinator?
    
    private lazy var indicatorView = IndicatorView()
    
    private lazy var pageHeaderView: UIView = {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45)
        return header
    }()
    
    private lazy var pageHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2(.semibold)
        label.text = viewModel.pageTitleLabel
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.isUserInteractionEnabled = true
        return tv
    }()
    
    init(title: String, category: CategoryType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = BookListVM(view: self, title: title, category: category)
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
extension BookListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier, for: indexPath) as! BookListTableViewCell
        let viewModel = BookListTableViewCellVM(view: cell, arguments: self.viewModel.tableCellForItem(at: indexPath))
        cell.viewModel = viewModel
        viewModel.authorClickListener = self
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

// MARK: - BookListVCDelegate
extension BookListVC: BookListVCDelegate {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.identifier)
        tableView.tableHeaderView = pageHeaderView
    }
    
    func constraintTableView() {
        view.addSubview(tableView)
        pageHeaderView.addSubview(pageHeaderLabel)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        pageHeaderLabel.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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

// MARK: - AuthorClickListener
extension BookListVC: AuthorClickListener {
    func onClickAuthor(authorName: String) {
        coordinator?.navigateAuthorBookListVC(authorName: authorName)
    }
}
