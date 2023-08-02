//
//  PostDataSource.swift
//  TikTokAsyncDisplay
//
//  Created by RX on 8/2/23.
//

import Foundation
import AsyncDisplayKit

class PostDataSource: DeepDiffDataSource<Post>, ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return getCount()
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let post = data.getValues()[indexPath.row]
        let nodeBlock = { () -> ASCellNode in
            let node = PostNode(post: post)
            return node
        }
        return nodeBlock
    }
}
