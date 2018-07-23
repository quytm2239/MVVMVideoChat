//
//  Collection.swift
//  TourDe
//
//  Created by Hoang Huynh Man on 5/24/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
