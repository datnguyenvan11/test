//
//  VideoTableViewCell.swift
//  YoutubeAPI
//
//  Created by Đạt on 24/07/2020.
//  Copyright © 2020 Đạt. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var date: UILabel!
    var video : Item?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setVideo (_ v : Item ){
        self.video = v
        self.title.text = video?.snippet.title
//        let df = DateFormatter()
//        df.dateFormat="EEEE , d MMM , yyyy"
//        self.date.text = df.string(from: v.snippet.publishedAt)
        guard self.video?.snippet.thumbnails.high.url != nil else{
            return
        }
        let url  = URL(string: self.video!.snippet.thumbnails.high.url)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data,reponse,error) in
            if error == nil && data != nil{
                if url!.absoluteString != self.video?.snippet.thumbnails.high.url{
                    return
                }
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.thumbnail.image = image
                }
           }
        }).resume()
    }
    
}
