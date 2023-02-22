//
//  Note.swift
//  NinjaNotes
//
//  Created by Arip Khozhbanov on 22.02.2023.
//

import Foundation

class Note {
    let id = UUID()
    var text: String = ""
    var lastUpdated: Date = Date()
    
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
    }
    
    var desc: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")" // return second line
    }
}
