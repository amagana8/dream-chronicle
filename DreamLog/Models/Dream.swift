//
//  Dream.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/12/21.
//

import SwiftUI

struct Dream: Identifiable, Codable {
    let id: UUID
    var title: String
    var summary: String
    var date: Date
    var lucidity: Int
    var clarity: Int
    var color: Color


    init(id: UUID = UUID(), title: String, summary: String, date: Date, lucidity: Int, clarity: Int, color: Color) {
        self.id = id
        self.title = title
        self.summary = summary
        self.date = date
        self.lucidity = lucidity
        self.clarity = clarity
        self.color = color
    }
}

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter.string(from: date)
}

extension Dream {
    static var data: [Dream] {
        []
    }
}

extension Dream {
    struct Data {
        var title: String = ""
        var summary: String = ""
        var date: Date = Date.init()
        var lucidity: Double = 0.0
        var clarity: Double = 0.0
        var color: Color = .random
    }
    
    var data: Data {
        return Data(title: title, summary: summary, date: date, lucidity: Double(lucidity), clarity: Double(clarity), color: color)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        summary = data.summary
        date = data.date
        lucidity = Int(data.lucidity)
        clarity = Int(data.clarity)
        color = data.color
    }
}
