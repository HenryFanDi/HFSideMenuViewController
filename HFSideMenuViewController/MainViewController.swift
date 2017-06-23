//
//  MainViewController.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 28/7/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var leftMenuBtn: UIButton!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainViewController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  fileprivate func setupMainViewController() {
    setupTitleLabel()
    setupLeftMenuBtn()
  }
  
  fileprivate func setupTitleLabel() {
    titleLabel.text = "MainViewController"
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.systemFont(ofSize: 16.0)
  }
  
  fileprivate func setupLeftMenuBtn() {
    leftMenuBtn.setTitle("LeftMenu", for: UIControlState())
    leftMenuBtn.setTitleColor(.black, for: UIControlState())
    leftMenuBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
    leftMenuBtn.titleLabel?.textAlignment = .center
    leftMenuBtn.layer.borderWidth = 1.0
    leftMenuBtn.layer.borderColor = UIColor.black.cgColor
    leftMenuBtn.layer.cornerRadius = 10.0
  }
  
  // MARK: IBAction
  
  @IBAction func leftMenuBtnOnTap(_ sender: UIButton) {
    HFSideMenuHelper.sharedInstance.toggleLeftMenuWithAnimation()
  }
  
}
