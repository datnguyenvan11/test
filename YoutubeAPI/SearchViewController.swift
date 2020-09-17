//
//  SearchViewController.swift
//  YoutubeAPI
//
//  Created by Đạt on 28/07/2020.
//  Copyright © 2020 Đạt. All rights reserved.
//

import UIKit
import Hero
class SearchViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var searchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.searchBar.delegate = self;
        self.textFieldShouldReturn(searchBar)

}
    override func viewDidAppear(_ animated: Bool) {
         searchBar.becomeFirstResponder()
       

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         searchBar.returnKeyType = UIReturnKeyType.search
//        if searchBar.text != nil && searchBar.text != ""{
            print(searchBar?.text ?? " l")
//        }
    return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        searchBar.clearButtonMode = .always
        searchBar.clearButtonMode = .whileEditing
        viewSearchBar.addBottomBorderWithColor(color: .black, width: 0.5)
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
