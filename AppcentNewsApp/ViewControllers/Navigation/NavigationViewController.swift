//
//  NavigationViewController.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit

class NavigationViewController: UIViewController {
    
    var heartButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private and Selector Functions
extension NavigationViewController {

    private func setupView() {
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        heartButton = UIBarButtonItem(image: IconPalette.heart, style: .plain, target: self, action: #selector(didTapHeartButton))
        heartButton.tintColor = .black

        let downloadButton = UIBarButtonItem(image: IconPalette.arrowDownCircle, style: .plain, target: self, action: #selector(didTapDownloadButton))
        downloadButton.tintColor = .black

        navigationItem.rightBarButtonItems = [heartButton, downloadButton]
    }

    @objc func  didTapHeartButton() {
        if heartButton.image ==  IconPalette.heart {
            heartButton.image =  IconPalette.heartFill
        } else {
            heartButton.image =  IconPalette.heart
        }
    }

    @objc func didTapDownloadButton() {
    }
}
