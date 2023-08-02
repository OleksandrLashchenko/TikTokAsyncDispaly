//
//  PostNode.swift
//  TikTokAsyncDisplay
//
//  Created by RX on 8/2/23.
//

import Foundation
import AsyncDisplayKit

class PostNode: ASCellNode {
    
    let post: Post
    let videoNode = ASVideoPlayerNode()
    
    init(post: Post) {
        self.post = post
        super.init()
        
        backgroundColor = .black
        
        videoNode.gravity = post.isLandscape ? AVLayerVideoGravity.resizeAspect.rawValue : AVLayerVideoGravity.resizeAspectFill.rawValue
        videoNode.shouldAutoPlay = true
        videoNode.shouldAutoRepeat = true
        videoNode.controlsDisabled = true
        
        DispatchQueue.main.async { [self] in
            videoNode.assetURL = URL(string: post.url)
        }
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        videoNode.style.preferredSize = UIScreen.main.bounds.size
        return ASAbsoluteLayoutSpec(children: [videoNode])
    }
}
