//
//  PhotoCollectionNavigationController.swift
//  TransitionSampler
//
//  Created by kazushi.hara on 2016/06/04.
//  Copyright © 2016年 haranicle. All rights reserved.
//

import Foundation
import UIKit

public class PhotoCollectionNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
}