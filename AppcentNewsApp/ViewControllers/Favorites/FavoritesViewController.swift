//
//  FavouritesViewController.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        setupTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getArticles()
    }
}

// MARK: - Private Functions
private extension FavoritesViewController {
    
    func setupTableView() {
        
        tableView.register(nibName: NewsTableViewCell.nibName)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getArticles() {
        articles = LocalDBManager.shared.getSavedArticles()
        tableView.reloadData()
    }
}

// MARK: - TableView Functions
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
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


