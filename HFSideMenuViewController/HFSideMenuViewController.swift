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
    case hfSideMenuMain
    case hfSideMenuLeft
    case hfSideMenuRight
  }
  
  enum HFSideMenuPositionType {
    case hfSideMenuPositionDefault
    case hfSideMenuPositionLeft
    case hfSideMenuPositionRight
  }
  
  enum HFSideMenuStatusType {
    case hfSideMenuStatusUnknown
    case hfSideMenuStatusOpen
    case hfSideMenuStatusClose
  }
  
  enum HFSideMenuTransitionType {
    case hfSideMenuTransitionUnknown
    case hfSideMenuTransitionToRight
    case hfSideMenuTransitionResetFromRight
  }
  
  var menuWidth: CGFloat
  var menuAnimationDuration: CGFloat
  
  fileprivate var mainViewController: UIViewController
  fileprivate var leftViewController: UIViewController
  
  fileprivate var mainView: UIView
  fileprivate var hideView: UIView
  fileprivate var leftMenuView: UIView
  
  fileprivate var leftMenuStatus: HFSideMenuStatusType
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(mainViewController: UIViewController(), leftMenuViewController: UIViewController())
  }
  
  init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
    self.menuWidth = UIScreen.main.bounds.width - 100
    self.menuAnimationDuration = 0.5
    
    self.mainViewController = mainViewController
    self.leftViewController = leftMenuViewController
    
    self.mainView = UIView()
    self.hideView = UIView()
    self.leftMenuView = UIView()
    
    self.leftMenuStatus = .hfSideMenuStatusUnknown
    super.init(nibName: nil, bundle: nil)
    HFSideMenuHelper.sharedInstance.sideMenuViewController = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllerWithSideMenuType(.hfSideMenuLeft)
    setupView()
    setupViewControllerWithSideMenuType(.hfSideMenuMain)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  fileprivate func setupView() {
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    setupMainView()
    setupHideView()
  }
  
  fileprivate func setupMainView() {
    mainView.frame = view.bounds
    mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(mainView)
  }
  
  fileprivate func setupHideView() {
    hideView.frame = view.bounds
    hideView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    hideView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hideView.alpha = 0.0
    mainView.addSubview(hideView)
    setupHideViewTapGesture()
  }
  
  fileprivate func setupHideViewTapGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(HFSideMenuViewController.hideViewOnTap))
    tapGestureRecognizer.numberOfTapsRequired = 1
    hideView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  func hideViewOnTap() {
    toggleLeftMenuWithAnimation()
  }
  
  fileprivate func setupViewControllerWithSideMenuType(_ sideMenuType: HFSideMenuType) {
    if sideMenuType == .hfSideMenuMain {
      setupSideMenuMain()
    } else if sideMenuType == .hfSideMenuLeft {
      setupSideMenuLeft()
    } else if sideMenuType == .hfSideMenuRight {
    }
  }
  
  fileprivate func setupSideMenuMain() {
    mainViewController.view.frame = mainViewFrameWithSideMenuPositionType(.hfSideMenuPositionDefault)
    addViewController(mainViewController, toView: mainView)
  }
  
  fileprivate func setupSideMenuLeft() {
    leftMenuView = leftViewController.view
    leftMenuStatus = .hfSideMenuStatusClose
    addViewController(leftViewController, toView: view)
    resizeMenuView(leftMenuView, sideMenuType: .hfSideMenuLeft)
  }
  
  // MARK: ViewControllers
  
  fileprivate func addViewController(_ fromViewController: UIViewController, toView: UIView) {
    toView.addSubview(fromViewController.view)
  }
  
  // MARK: Frames
  
  fileprivate func mainViewFrameWithSideMenuPositionType(_ sideMenuPositionType: HFSideMenuPositionType) -> CGRect {
    var frame = view.bounds
    if sideMenuPositionType == .hfSideMenuPositionLeft {
      frame.origin.x -= menuWidth
    } else if sideMenuPositionType == .hfSideMenuPositionRight {
      frame.origin.x += menuWidth
    }
    return frame
  }
  
  fileprivate func leftMenuViewFrameWithSideMenuStatusType(_ sideMenuStatusType: HFSideMenuStatusType) -> CGRect {
    var frame = view.bounds
    frame.size.width = menuWidth
    return frame
  }
  
  fileprivate func resizeMenuView(_ menuView: UIView, sideMenuType: HFSideMenuType) {
    menuView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    if sideMenuType == .hfSideMenuLeft {
      menuView.frame = leftMenuViewFrameWithSideMenuStatusType(.hfSideMenuStatusClose)
    } else if sideMenuType == .hfSideMenuRight {
    }
    menuView.sizeThatFits(CGSize(width: menuWidth, height: view.frame.height))
  }
  
  fileprivate func getMainViewFrameWithSideMenuTransitionType(_ sideMenuTransitionType: HFSideMenuTransitionType) -> CGRect {
    if sideMenuTransitionType == .hfSideMenuTransitionResetFromRight {
      return mainViewFrameWithSideMenuPositionType(.hfSideMenuPositionDefault)
    }
    return mainViewFrameWithSideMenuPositionType(.hfSideMenuPositionRight)
  }
  
  fileprivate func getMenuViewFrameWithSideMenuTransitionType(_ sideMenuTransitionType: HFSideMenuTransitionType) -> CGRect {
    if sideMenuTransitionType == .hfSideMenuTransitionResetFromRight {
      return leftMenuViewFrameWithSideMenuStatusType(.hfSideMenuStatusClose)
    } else if sideMenuTransitionType == .hfSideMenuTransitionToRight {
      return leftMenuViewFrameWithSideMenuStatusType(.hfSideMenuStatusOpen)
    }
    return CGRect.zero
  }
  
  // MARK: Status
  
  fileprivate func setSideMenuStatusWithSideMenuTransitionType(_ sideMenuTransitionType: HFSideMenuTransitionType) {
    if sideMenuTransitionType == .hfSideMenuTransitionResetFromRight {
      leftMenuStatus = .hfSideMenuStatusClose
    } else if sideMenuTransitionType == .hfSideMenuTransitionToRight {
      leftMenuStatus = .hfSideMenuStatusOpen
    }
  }
  
  // MARK: Hide
  
  fileprivate func setHideViewWithSideMenuTransitionType(_ sideMenuTransitionType: HFSideMenuTransitionType) {
    unowned let ownedSelf = self
    if sideMenuTransitionType == .hfSideMenuTransitionResetFromRight {
      UIView.animate(withDuration: Double(menuAnimationDuration) , animations: {
        ownedSelf.hideView.alpha = 0.0
      }, completion: { (finished) in
        ownedSelf.mainView.sendSubview(toBack: ownedSelf.hideView)
      })
    } else if sideMenuTransitionType == .hfSideMenuTransitionToRight {
      mainView.bringSubview(toFront: hideView)
      UIView.animate(withDuration: Double(menuAnimationDuration), animations: {
        ownedSelf.hideView.alpha = 1.0
      })
    }
  }
  
  // MARK: Toggle
  
  func toggleLeftMenuWithAnimation() {
    toggleMenuWithSideMenuType(.hfSideMenuLeft, animated: true)
  }
  
  fileprivate func toggleMenuWithSideMenuType(_ sideMenuType: HFSideMenuType, animated: Bool) {
    let sideMenuTransitionType = getSideMenuTransitionTypeWithSideMenuType(sideMenuType)
    beginWithSideMenuTransitionType(sideMenuTransitionType, animated: animated) {
    }
  }
  
  // MARK: Transition
  
  fileprivate func getSideMenuTransitionTypeWithSideMenuType(_ sideMenuType: HFSideMenuType) -> HFSideMenuTransitionType {
    if sideMenuType == .hfSideMenuLeft {
      if leftMenuStatus == .hfSideMenuStatusOpen {
        return .hfSideMenuTransitionResetFromRight
      } else {
        return .hfSideMenuTransitionToRight
      }
    }
    return .hfSideMenuTransitionUnknown
  }
  
  fileprivate func beginWithSideMenuTransitionType(_ sideMenuTransitionType: HFSideMenuTransitionType, animated: Bool, completion: () -> Void) {
    view.endEditing(true)
    setSideMenuStatusWithSideMenuTransitionType(sideMenuTransitionType)
    setHideViewWithSideMenuTransitionType(sideMenuTransitionType)
    
    let menuView = leftMenuView // TODO: Type
    if !animated {
      menuView.frame = getMenuViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
      mainView.frame = getMainViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
    } else {
      unowned let ownedSelf = self
      UIView.animate(withDuration: Double(menuAnimationDuration), animations: {
        menuView.frame = ownedSelf.getMenuViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
        ownedSelf.mainView.frame = ownedSelf.getMainViewFrameWithSideMenuTransitionType(sideMenuTransitionType)
      })
    }
  }
  
}
