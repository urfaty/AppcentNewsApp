//
//  NewsTableViewCell.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var newsDescription: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    
    var article: Article? {
        didSet {
            newsImageView.setImage(with: article?.urlToImage)
            newsDescription.text = article?.description
            newsTitle.text = article?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        article = nil
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        article = nil
    }
}


