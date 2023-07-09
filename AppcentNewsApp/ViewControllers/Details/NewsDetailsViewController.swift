//
//  NewsDetailsViewController.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit

final class NewsDetailsViewController: NavigationViewController {
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UITextView!
    
    
    private let article: Article
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHeartButton()
    }
    
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")        
    }
    
    
    @IBAction func newsSourceButton(_ sender: Any) {
        let webView = WebViewController(websiteUrl: article.url ?? NetworkManager.shared.errorUrl)
        webView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(webView, animated: true)
    }
    
    override func didTapHeartButton() {
        super.didTapHeartButton()
        if heartButton.image == IconPalette.heartFill {
            saveArticleToLocalDatabase()
        } else {
            removeArticleFromLocalDatabase()
        }
    }
}

// MARK: - Private Functions
private extension NewsDetailsViewController {
    func setUpView() {
        newsTitleLabel.text = article.title
        authorNameLabel.text = article.author
        descriptionLabel.text = article.description
        dateLabel.text = Date.displayString(fromISO8601: article.publishedAt)
        newsImageView.setImage(with: article.urlToImage)
    }
    
    func updateHeartButton() {
        if LocalDBManager.shared.isArticleSaved(article) {
            heartButton.image = IconPalette.heartFill
        } else {
            heartButton.image = IconPalette.heart
        }
    }
    
    func saveArticleToLocalDatabase() {
        LocalDBManager.shared.saveArticleToLocalDatabase(article)
        print(LocalDBManager.shared.getSavedArticles())
    }
    
    func removeArticleFromLocalDatabase() {
        LocalDBManager.shared.removeArticleFromLocalDatabase(article)
        print(LocalDBManager.shared.getSavedArticles())
        
    }
    func setUpNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: .empty, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.black
    }
}
