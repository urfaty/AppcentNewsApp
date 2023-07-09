//
//  Logger.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 9.07.2023.
//

import Foundation

final class Logger {
    
    static let shared = Logger()
    
    private init() { }
    
    
    var shouldPrint: Bool = true
    
    func log(text: String, function: String = #function, line: Int = #line, filePath: String = #filePath) {
        
        guard shouldPrint else { return }
        
        print("<<<<<-----")
        
        print(text)
        print(function)
        print(line)
        print(filePath)
        
        print("----->>>>>")
    }
}
