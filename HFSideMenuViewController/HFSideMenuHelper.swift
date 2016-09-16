//
//  HFSideMenuHelper.swift
//  HFSideMenuViewController
//
//  Created by HenryFan on 16/9/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSideMenuHelper: NSObject {
  
  private var _sideMenuViewController: HFSideMenuViewController?
  var sideMenuViewController: HFSideMenuViewController? {
    set { _sideMenuViewController = newValue }
    get { return _sideMenuViewController }
  }
  
  // MARK: Singleton Pattern
  
  class var shard: HFSideMenuHelper {
    struct Static {
      static var instance: HFSideMenuHelper?
      static var token: dispatch_once_t = 0
    }
    dispatch_once(&Static.token) { 
      Static.instance = HFSideMenuHelper()
    }
    return Static.instance!
  }
  
  // MARK: Public
  
  func toggleLeftMenuWithAnimation() {
    sideMenuViewController?.toggleLeftMenuWithAnimation()
  }
  
}
