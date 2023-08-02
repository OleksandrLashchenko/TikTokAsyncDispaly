//
//  Post.swift
//  TikTokAsyncDisplay
//
//  Created by RX on 8/2/23.
//

import Foundation
import DeepDiff

struct Post: Codable, Hashable, DiffAware {
    var id: String
    var url: String
    var isLandscape: Bool
    
    init(url: String, isLandscape: Bool) {
        self.id = UUID().uuidString
        self.url = url
        self.isLandscape = isLandscape
    }
}
