//
//  NetworkManager.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//


import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    var defaultQuery = "besiktas"
    var page = 1
    var apiKey = "03284706c234497899151431a42dd18d"
    var errorUrl = "https://www.google.com"
    
    
    private init() { }
 
    func getNews(query: String, page: Int, apiKey: String, completion: @escaping (_ response: NewsResponse) -> Void) {

        var components = URLComponents(string: "https://newsapi.org/v2/everything")
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = components?.url else {
            // TODO: Handle the error.
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            
            guard let data = data else {
                // TODO: Handle the error.
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(apiResponse)
            } catch {
                print("--* \(error.localizedDescription)")
            }
            
        }.resume()
    }

}
