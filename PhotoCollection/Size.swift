//
//  Size.swift
//  TransitionSampler
//
//  Created by kazushi.hara on 2016/06/06.
//  Copyright © 2016年 haranicle. All rights reserved.
//

import Foundation

public struct Size {
    
    public static let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
    
    public static func navigationBarHeight(viewController: UIViewController) -> CGFloat {
        return viewController.navigationController?.navigationBar.frame.size.height ?? CGFloat(44)
    }
    
    public static func appBarHeight(viewController: UIViewController) -> CGFloat {
        return statusBarHeight + navigationBarHeight(viewController)
    }
    
    public static func toolbarHeight(viewController: UIViewController) -> CGFloat {
        guard let navigationController = viewController.navigationController else {
            return 0
        }
        guard !navigationController.toolbarHidden else {
            return 0
        }
        return navigationController.toolbar.frame.size.height
    }
    
    public static func screenRectWithoutAppBar(viewController: UIViewController) -> CGRect {
        let appBarHeight = Size.appBarHeight(viewController)
        let toolbarHeight = Size.toolbarHeight(viewController)
        return CGRect(
            x: 0,
            y: appBarHeight,
            width: UIScreen.mainScreen().bounds.width,
            height: UIScreen.mainScreen().bounds.height - appBarHeight - toolbarHeight)
    }
}