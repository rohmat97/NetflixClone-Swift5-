//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Rohmat Dasuki on 16/02/23.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
