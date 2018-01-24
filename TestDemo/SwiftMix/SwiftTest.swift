//
//  SwiftTest.swift
//  TestDemo
//
//  Created by vane on 04/01/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

import UIKit

class SwiftTest: NSObject {
    func f1() -> String {
        return "Test Mix"
    }
    
    func f2() {
        let vc = SwiftOCTest()
        let str: String = vc.swiftString
        
        NSLog("log swift string:%@", str);
    }
}
