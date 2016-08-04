//
//  HFSideMenuViewController.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 29/7/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSideMenuViewController: UIViewController {
  
  enum HFSideMenuType {
    case HFSideMenuMain
    case HFSideMenuLeft
    case HFSideMenuRight
  }
  
  enum HFSideMenuPositionType {
    case HFSideMenuPositionDefault
    case HFSideMenuPositionLeft
    case HFSideMenuPositionRight
  }
  
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
    setupViewControllerWithSideMenuType(.HFSideMenuMain)
    setupView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  private func setupView() {
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    setupMainView()
  }
  
  private func setupMainView() {
    mainView.frame = view.bounds
    mainView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    view.addSubview(mainView)
  }
  
  private func setupViewControllerWithSideMenuType(sideMenuType: HFSideMenuType) {
    if sideMenuType == .HFSideMenuMain {
      mainViewController.view.frame = mainViewFrameWithSideMenuPositionType(.HFSideMenuPositionDefault)
      addViewController(mainViewController, toView: mainView)
    } else if sideMenuType == .HFSideMenuLeft {
    } else if sideMenuType == .HFSideMenuRight {
    }
  }
  
  // MARK: ViewControllers
  
  private func addViewController(fromViewController: UIViewController, toView: UIView) {
    toView.addSubview(fromViewController.view)
  }
  
  // MARK: Frames
  
  private func mainViewFrameWithSideMenuPositionType(sideMenuPositionType: HFSideMenuPositionType) -> CGRect {
    var frame = view.bounds
    if sideMenuPositionType == .HFSideMenuPositionLeft {
      frame.origin.x -= menuWidth
    } else if sideMenuPositionType == .HFSideMenuPositionRight {
      frame.origin.x += menuWidth
    }
    return frame
  }
  
}
