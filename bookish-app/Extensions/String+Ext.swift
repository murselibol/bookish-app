//
//  String+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 18.01.2024.
//

import Foundation

extension String {
    func htmlToString() -> String? {
        do {
            let attributedString = try NSAttributedString(
                data: Data(utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            return attributedString.string
        } catch {
            print("HTML to String conversion error: \(error)")
            return nil
        }
    }
}
