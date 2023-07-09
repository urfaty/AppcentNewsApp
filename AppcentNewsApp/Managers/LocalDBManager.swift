//
//  LocalDBManager.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//


import Foundation
import CoreData
import UIKit

struct LocalDBManager {
    
    static let shared = LocalDBManager()
       private let savedArticlesKey = "savedArticles"
       
       private init() {}
       
       func saveArticleToLocalDatabase(_ article: Article) {
           var savedArticles = getSavedArticles()
           savedArticles.append(article)
           if let data = try? JSONEncoder().encode(savedArticles) {
               UserDefaults.standard.set(data, forKey: savedArticlesKey)
           }
       }
       
       func removeArticleFromLocalDatabase(_ article: Article) {
           var savedArticles = getSavedArticles()
           savedArticles.removeAll { $0.title == article.title }
           if let data = try? JSONEncoder().encode(savedArticles) {
               UserDefaults.standard.set(data, forKey: savedArticlesKey)
           }
       }
       
       func isArticleSaved(_ article: Article) -> Bool {
           let savedArticles = getSavedArticles()
           return savedArticles.contains { $0.title == article.title }
       }

       
       func getSavedArticles() -> [Article] {
           if let data = UserDefaults.standard.data(forKey: savedArticlesKey),
              let savedArticles = try? JSONDecoder().decode([Article].self, from: data) {
               return savedArticles
           }
           return []
       }
}
