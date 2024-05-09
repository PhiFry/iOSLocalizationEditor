//
//  String+Extensions.swift
//  LocalizationEditor
//
//  Created by Igor Kulman on 05/02/2019.
//  Copyright © 2019 Igor Kulman. All rights reserved.
//

import Foundation

extension String {
    func slice(from fromString: String, to toString: String) -> String? {
        return (range(of: fromString)?.upperBound).flatMap { substringFrom in
            (range(of: toString, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }

    var normalized: String {
        return folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
    }

    var capitalizedFirstLetter: String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    var unescaped: String {
        let entities = [
            "\\n": "\n",
            "\\t": "\t",
            "\\r": "\r",
            "\\\"": "\"",
            "\\\'": "\'",
            "\\\\": "\\"
        ]
        var current = self
        for (key, value) in entities {
            current = current.replacingOccurrences(of: key, with: value)
        }
        return current
    }

    var escaped: String {
        return self.replacingOccurrences(of: "\"", with: "\\\"").replacingOccurrences(of: "\n", with: "\\n")
    }

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
