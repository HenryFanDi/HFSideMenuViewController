//
//  MainViewController.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 28/7/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func leftMenuBtnOnTap(sender: UIButton) {
    let sideMenuViewController = (UIApplication.sharedApplication().delegate as! AppDelegate).sideMenuViewController
    sideMenuViewController?.toggleLeftMenuWithAnimation()
  }
  
}
