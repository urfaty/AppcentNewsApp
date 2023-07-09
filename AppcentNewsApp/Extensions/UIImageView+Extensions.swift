//
//  UIImageView+Extensions.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String?) {
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        
        self.kf.setImage(with: url)
    }
}
