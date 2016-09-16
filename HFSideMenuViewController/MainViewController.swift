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
  
  private func setupMainViewController() {
    setupTitleLabel()
    setupLeftMenuBtn()
  }
  
  private func setupTitleLabel() {
    titleLabel.text = "MainViewController"
    titleLabel.textColor = .blackColor()
    titleLabel.textAlignment = .Center
    titleLabel.font = UIFont.systemFontOfSize(16.0)
  }
  
  private func setupLeftMenuBtn() {
    leftMenuBtn.setTitle("LeftMenu", forState: .Normal)
    leftMenuBtn.setTitleColor(.blackColor(), forState: .Normal)
    leftMenuBtn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
    leftMenuBtn.titleLabel?.textAlignment = .Center
    leftMenuBtn.layer.borderWidth = 1.0
    leftMenuBtn.layer.borderColor = UIColor.blackColor().CGColor
    leftMenuBtn.layer.cornerRadius = 10.0
  }
  
  // MARK: IBAction
  
  @IBAction func leftMenuBtnOnTap(sender: UIButton) {
    HFSideMenuHelper.shard.toggleLeftMenuWithAnimation()
  }
  
}
