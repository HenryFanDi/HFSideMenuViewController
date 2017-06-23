//
//  LeftMenuViewController.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 15/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLeftMenuViewController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  fileprivate func setupLeftMenuViewController() {
    view.backgroundColor = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    setupTitleLabel()
  }
  
  fileprivate func setupTitleLabel() {
    titleLabel.text = "LeftMenuViewController"
    titleLabel.textColor = UIColor.black
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.systemFont(ofSize: 16.0)
  }
  
}
