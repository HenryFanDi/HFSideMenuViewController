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
  
  enum HFSideMenuStatusType {
    case HFSideMenuStatusUnknown
    case HFSideMenuStatusOpen
    case HFSideMenuStatusClose
  }
  
  enum HFSideMenuTransitionType {
    case HFSideMenuTransitionUnknown
    case HFSideMenuTransitionToRight
    case HFSideMenuTransitionResetFromLeft
  }
  
  private var menuWidth: CGFloat
  private var mainViewController: UIViewController
  private var leftViewController: UIViewController
  
  private var mainView: UIView
  private var hideView: UIView
  private var leftMenuView: UIView
  private var animationDuration: CGFloat
  
  private var leftMenuStatus: HFSideMenuStatusType
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(mainViewController: UIViewController(), leftMenuViewController: UIViewController())
  }
  
  init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
    self.menuWidth = CGRectGetWidth(mainViewController.view.frame) - 60.0
    self.mainViewController = mainViewController
    self.leftViewController = leftMenuViewController
    
    self.mainView = UIView()
    self.hideView = UIView()
    self.leftMenuView = UIView()
    self.animationDuration = 0.3
    
    self.leftMenuStatus = .HFSideMenuStatusUnknown
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
    setupHideView()
  }
  
  private func setupMainView() {
    mainView.frame = view.bounds
    mainView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    view.addSubview(mainView)
  }
  
  private func setupHideView() {
    hideView.frame = view.bounds
    hideView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    hideView.alpha = 0.0
    mainView.addSubview(hideView)
  }
  
  private func setupHideViewTapGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(HFSideMenuViewController.hideViewOnTap))
    tapGestureRecognizer.numberOfTapsRequired = 1
    hideView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  func hideViewOnTap() {
    toggleLeftMenuWithAnimation()
  }
  
  private func setupViewControllerWithSideMenuType(sideMenuType: HFSideMenuType) {
    if sideMenuType == .HFSideMenuMain {
      mainViewController.view.frame = mainViewFrameWithSideMenuPositionType(.HFSideMenuPositionDefault)
      addViewController(mainViewController, toView: mainView)
    } else if sideMenuType == .HFSideMenuLeft {
      leftMenuView = leftViewController.view
      leftMenuStatus = .HFSideMenuStatusClose
      addViewController(leftViewController, toView: view)
      resizeMenuView(leftMenuView, sideMenuType: .HFSideMenuLeft)
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
  
  private func leftMenuViewFrameWithSideMenuStatusType(sideMenuStatusType: HFSideMenuStatusType) -> CGRect {
    var frame = view.bounds
    frame.size.width = menuWidth
    return frame
  }
  
  private func resizeMenuView(menuView: UIView, sideMenuType: HFSideMenuType) {
    menuView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    
    if sideMenuType == .HFSideMenuLeft {
      menuView.frame = leftMenuViewFrameWithSideMenuStatusType(.HFSideMenuStatusClose)
    } else if sideMenuType == .HFSideMenuRight {
    }
    menuView.sizeThatFits(CGSizeMake(menuWidth, CGRectGetHeight(view.frame)))
  }
  
  private func getMainViewFrameWithSideMenuTransitionType(sideMenuTransitionType: HFSideMenuTransitionType) -> CGRect {
    if sideMenuTransitionType == .HFSideMenuTransitionResetFromLeft {
      return mainViewFrameWithSideMenuPositionType(.HFSideMenuPositionDefault)
    }
    return mainViewFrameWithSideMenuPositionType(.HFSideMenuPositionRight)
  }
  
  private func getMenuViewFrameWithSideMenuTransitionType(sideMenuTransitionType: HFSideMenuTransitionType) -> CGRect {
    if sideMenuTransitionType == .HFSideMenuTransitionResetFromLeft {
      return leftMenuViewFrameWithSideMenuStatusType(.HFSideMenuStatusClose)
    } else if sideMenuTransitionType == .HFSideMenuTransitionToRight {
      return leftMenuViewFrameWithSideMenuStatusType(.HFSideMenuStatusOpen)
    }
    return CGRectZero
  }
  
  // MARK: Status
  
  private func setSideMenuStatusWithSideMenuTransitionType(sideMenuTransitionType: HFSideMenuTransitionType) {
    if sideMenuTransitionType == .HFSideMenuTransitionResetFromLeft {
      leftMenuStatus = .HFSideMenuStatusClose
    } else if sideMenuTransitionType == .HFSideMenuTransitionToRight {
      leftMenuStatus = .HFSideMenuStatusOpen
    }
  }
  
  // MARK: Toggle
  
  func toggleLeftMenuWithAnimation() {
    toggleMenuWithSideMenuType(.HFSideMenuLeft, animated: true)
  }
  
  private func toggleMenuWithSideMenuType(sideMenuType: HFSideMenuType, animated: Bool) {
    let sideMenuTransitionType = getSideMenuTransitionTypeWithSideMenuType(sideMenuType)
    beginWithSideMenuTransitionType(sideMenuTransitionType, animated: animated) {
    }
  }
  
  // MARK: Transition
  
  private func getSideMenuTransitionTypeWithSideMenuType(sideMenuType: HFSideMenuType) -> HFSideMenuTransitionType {
    if sideMenuType == .HFSideMenuLeft {
      if leftMenuStatus == .HFSideMenuStatusOpen {
        return .HFSideMenuTransitionResetFromLeft
      } else {
        return .HFSideMenuTransitionToRight
      }
    }
    return .HFSideMenuTransitionUnknown
  }
  
  private func beginWithSideMenuTransitionType(sideMenuTransitionType: HFSideMenuTransitionType, animated: Bool, completion: () -> Void) {
    view.endEditing(true)
    setSideMenuStatusWithSideMenuTransitionType(sideMenuTransitionType)
    
    // TODO: Hide
    
    let menuView = leftMenuView // TODO: Type
    if !animated {
      menuView.frame = getMenuViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
      mainView.frame = getMainViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
    } else {
      unowned let ownedSelf = self
      UIView.animateWithDuration(0.3, animations: { 
        menuView.frame = ownedSelf.getMenuViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
        ownedSelf.mainView.frame = ownedSelf.getMainViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
      })
    }
  }
  
}
