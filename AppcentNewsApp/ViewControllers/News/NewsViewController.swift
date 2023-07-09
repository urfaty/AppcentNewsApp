//
//  NewsViewController.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit

final class NewsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var articles: [Article] = []
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appcent News App"
        setupTableView()
        getArticles()
        setupSearchBar()
        setUpNavigationBar()
    }
}

private extension NewsViewController {
    
    func setupTableView() {
        
        tableView.register(nibName: NewsTableViewCell.nibName)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func getArticles(query: String = NetworkManager.shared.defaultQuery) {
        NetworkManager.shared.getNews(query: query, page: NetworkManager.shared.page, apiKey: NetworkManager.shared.apiKey, completion: handleNewsResponse(response:))
    }
    
    func handleNewsResponse(response: NewsResponse) {
        
        self.articles = response.articles ?? []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setUpNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: .empty, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.black
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.nibName) as! NewsTableViewCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < articles.count else { return }
        let newsDetailsView = NewsDetailsViewController(article: articles[indexPath.row])
        newsDetailsView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newsDetailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension NewsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        getArticles(query: query)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

