//
//  ViewController.swift
//  TikTokAsyncDisplay
//
//  Created by RX on 8/2/23.
//

import UIKit
import AsyncDisplayKit
import DeepDiff

class ViewController: UIViewController {

    let dataSource = PostDataSource()
    
    private lazy var collection: ASCollectionNode = {
        let layout = PostCVLayout()
        let node = ASCollectionNode(collectionViewLayout: layout)
        
        layout.collectionNode = node
        node.dataSource = dataSource
        node.delegate = self
        node.showsVerticalScrollIndicator = false
        node.view.decelerationRate = .fast
        node.view.isPagingEnabled = true
        
        return node
    }()
    
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layout()
        loadPosts()
        
        dataSource.data.updateDiff(old: [], new: posts)
        dataSource.data.addObserver(self) { [weak self] old, new, _ in
            guard let self = self else { return }
            let changes = diff(old: old, new: new)
            self.collection.view.reload(changes: changes) {
                print("reloaded changes")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let visibleNodes = collection.visibleNodes
        for cell in visibleNodes {
            if let node = cell as? PostNode {
                node.videoNode.pause()
            }
        }
    }


}

// MARK: - Private functions
extension ViewController {
    
    private func layout() {
        view.addSubview(collection.view)
        collection.view.translatesAutoresizingMaskIntoConstraints = false
        collection.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collection.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collection.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collection.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func loadPosts() {
        let post1 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/video0485/large_watermarked/_import_624e700fc79856.07433731_preview.mp4", isLandscape: false)
        let post2 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/2020-07/large_watermarked/200618_Covid%20BLM%20Portraits_04_HD_004_preview.mp4", isLandscape: true)
        let post3 = Post(url: "https://cdn.videvo.net/videvo_files/video/free/2022-12/large_watermarked/221207_03_Christmas%20Food%202_4k_018_preview.mp4", isLandscape: true)
        let post4 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/video0472/large_watermarked/_import_61a09dfe941456.83036877_preview.mp4", isLandscape: false)
        let post5 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/2022-05/large_watermarked/220509_01_London%20Student_4k_097_preview.mp4", isLandscape: true)
        let post6 = Post(url: "https://cdn.videvo.net/videvo_files/video/free/2022-11/large_watermarked/221017_01_Urban%20Football_4k_057_preview.mp4", isLandscape: true)
        let post7 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/video0485/large_watermarked/_import_624e702a6d3d86.37585296_preview.mp4", isLandscape: false)
        let post8 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/video0463/large_watermarked/_import_610bb740b2bcb6.04292901_preview.mp4", isLandscape: false)
        let post9 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/video0483/large_watermarked/_217__import_preview.mp4", isLandscape: true)
        let post10 = Post(url: "https://joy1.videvo.net/videvo_files/video/free/video0453/large_watermarked/_import_605e8705311679.82732032_preview.mp4", isLandscape: false)
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
        posts.append(post5)
        posts.append(post6)
        posts.append(post7)
        posts.append(post8)
        posts.append(post9)
        posts.append(post10)
    }
}

// MARK: - ASCollectionDelegate
extension ViewController: ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, willDisplayItemWith node: ASCellNode) {
        guard let item = node.indexPath?.item else { return }
        let post = self.posts[item]
        print("ViewController:: Will show a video located at \(post.url)")
    }
}
