//
//  Extensions.swift
//  NetFlix-Demo
//
//  Created by Hassan Azhar on 03/08/2022.
//

import Foundation

extension String{
    func capitalizerFirstLetter()->String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
