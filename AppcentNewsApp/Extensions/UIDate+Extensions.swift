//
//  UIDate+Extensions.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 7.07.2023.
//

import UIKit

extension Date {
    
    static func displayString(fromISO8601 string: String?) -> String? {
        guard let dateStr = string else { return nil }
        
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: dateStr) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short
        
        return displayFormatter.string(from: date)
    }
}

