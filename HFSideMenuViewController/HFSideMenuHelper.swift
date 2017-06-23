//
//  HFSideMenuHelper.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 16/9/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSideMenuHelper: NSObject {
  
  fileprivate var _sideMenuViewController: HFSideMenuViewController?
  var sideMenuViewController: HFSideMenuViewController? {
    set { _sideMenuViewController = newValue }
    get { return _sideMenuViewController }
  }
  
  // MARK: Singleton Pattern
  
  static let sharedInstance = HFSideMenuHelper()
  
  // MARK: Public
  
  func toggleLeftMenuWithAnimation() {
    sideMenuViewController?.toggleLeftMenuWithAnimation()
  }
  
}
