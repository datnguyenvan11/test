//
//  ViewController.swift
//  YoutubeAPI
//
//  Created by Đạt on 23/07/2020.
//  Copyright © 2020 Đạt. All rights reserved.
//

import UIKit
import Alamofire
import Hero
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ModelDelegate {
    
    @IBOutlet weak var Search: UIBarButtonItem!
    @IBOutlet  var table: UITableView!
    var model = Model()
    var videos = [Item]()
    
    @IBOutlet weak var avatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        table.dataSource = self
        table.delegate = self
         model.getVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        navigationController?.hidesBarsOnSwipe = true
        addLeftBarIcon(named: "logo_yt")
        navigationController!.hero.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addLeftBarIcon(named:String) {
        let logoImage = UIImage.init(named: named)
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRect(x:0.0,y:0.0, width:100 ,height:40.0)
        logoImageView.contentMode = .scaleToFill
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 40)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.leftBarButtonItem =  imageItem
    }
   
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Unhide")
            }, completion: nil)
        }
    }
    
    func FetchesVideo(_ videos:[Item]) {
        self.videos = videos
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell
        let video = self.videos[indexPath.row]
        cell.setVideo(video)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailvideo"{
            guard table.indexPathForSelectedRow != nil else {
                return
            }
            let selectedVideo = videos[(table.indexPathForSelectedRow?.row)!]
            let detailVC = segue.destination as! VideoDetailViewController
            detailVC.video = selectedVideo
        }
        if segue.identifier == "searchvideo"{
            let searchVC = segue.destination as! SearchViewController
             searchVC.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .up), dismissing: .auto)

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    }
   
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        
    }

}


    
    extension UIImageView {
        
        func makeRounded() {
            
            self.layer.borderWidth = 1
            self.layer.masksToBounds = false
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
    }

