//
//  HFSideMenuViewController.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 29/7/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSideMenuViewController: UIViewController {
  
  private var menuWidth: CGFloat
  private var mainViewController: UIViewController
  private var leftViewController: UIViewController
  
  private var mainView: UIView
  private var hideView: UIView
  private var animationDuration: CGFloat
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(mainViewController: UIViewController(), leftMenuViewController: UIViewController())
  }
  
  init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
    self.menuWidth = 0.0
    self.mainViewController = mainViewController
    self.leftViewController = leftMenuViewController
    
    self.mainView = UIView()
    self.hideView = UIView()
    self.animationDuration = 0.3
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  private func setupView() {
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
  }
  
}
