//
//  VideoDetailViewController.swift
//  YoutubeAPI
//
//  Created by Đạt on 27/07/2020.
//  Copyright © 2020 Đạt. All rights reserved.
//

import UIKit
import WebKit
import Hero
class VideoDetailViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var desVideo: UITextView!
    @IBOutlet weak var dateVideo: UILabel!
    @IBOutlet weak var titleVideo: UILabel!
    @IBOutlet weak var playView: WKWebView!
    var video : Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .up), dismissing: .auto)
        playView.navigationDelegate=self
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        desVideo.text = ""
        titleVideo.text = ""
        dateVideo.text = ""
        guard video != nil else{
            return
        }
        let stringUrl = "https://www.youtube.com/embed/" + (video?.id.videoId)!
        let urlrequest = URL(string: stringUrl)
        let request = URLRequest(url: urlrequest!)
        playView.load(request)
        desVideo.text = video?.snippet.description
        titleVideo.text = video?.snippet.title
        dateVideo.text = video?.snippet.publishedAt
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
