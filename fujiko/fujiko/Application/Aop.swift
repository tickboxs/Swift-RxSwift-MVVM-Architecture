//
//  Aop.swift
//  fujiko
//
//  Created by Charlie Cai on 22/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import Aspects
import CocoaLumberjack

final class Aop {
    static func registerAll() {
        
        do {
            
            let initAop = getObjcCallback { (instance) in
                Logger.log("\(String(describing: instance)) init", .debug)
            }

            let deinitAop = getObjcCallback { (instance) in
                Logger.log("\(String(describing: instance)) deinit", .debug)
            }

            let userDefaultSetAop = getObjcCallback { _ in
                Logger.log("You are setting user default", .debug)
            }

            let userDefaultRemoveAop = getObjcCallback { _ in
                Logger.log("You are removing user default", .debug)
            }
            
            // Log ViewController
            try UIViewController.aspect_hook(#selector(UIViewController.viewDidLoad),
                                             with: AspectOptions.positionBefore,
                                             usingBlock: initAop)
            
//            try ViewController.aspect_hook(#selector(ViewController.viewUnload),
//                                           with: AspectOptions.positionInstead,
//                                             usingBlock: deinitAop)
            
            // Log ViewModel
            try ViewModel.aspect_hook(#selector(ViewModel.init),
                                             with: AspectOptions.positionBefore,
                                             usingBlock: initAop)
            
//            try ViewModel.aspect_hook(#selector(ViewModel.viewModelUnload),
//                                             with: AspectOptions.positionBefore,
//                                             usingBlock: deinitAop)
            
            // Log UserDefaults
            try UserDefaults.aspect_hook(#selector(UserDefaults.setValue(_:forKey:)),
                                      with: AspectOptions.positionBefore,
                                      usingBlock: userDefaultSetAop)
            try UserDefaults.aspect_hook(#selector(UserDefaults.removeObject(forKey:)),
                                      with: AspectOptions.positionBefore,
                                      usingBlock: userDefaultRemoveAop)

        } catch {
            Logger.log("Something Wrong With AOP \(error)", .error)
        }

    }

    private static func getObjcCallback(action: @escaping (Any?) -> Void) -> AnyObject {
        let block: @convention(block) (AnyObject?) -> Void = {
            info in
            
            if let aspectInfo = info as? AspectInfo {
                 let instance =  aspectInfo.instance()
                    action(instance)
            } else {
                Logger.log("Could not execute AOP", .warn)
            }
        }
        let blobj: AnyObject = unsafeBitCast(block, to: AnyObject.self)
        
        return blobj
    }
}
