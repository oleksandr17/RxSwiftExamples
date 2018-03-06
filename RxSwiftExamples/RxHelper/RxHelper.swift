//
//  RxHelper.swift
//  BasicApp
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Elements Interactive. All rights reserved.
//

import RxSwift
import RxCocoa

struct RxHelper {
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Run
    
    static func run() {
        runChapter2()
        runChapter3()
        runChapter5()
        runChapter6()
        runChapter7()
//        logResourses()
        exit(0)
    }
}
