//
//  RxHelper+Utils.swift
//  BasicApp
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Elements Interactive. All rights reserved.
//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func example(title: String, action: () -> Void) {
        print("===================")
        print("Example: \(title)")
        action()
    }
    
    static func logResourses() {
        print("===================")
        print("RxSwift.Resources.total = \(RxSwift.Resources.total)")
    }
}
