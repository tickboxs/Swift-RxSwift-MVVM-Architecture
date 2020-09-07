//
//  Navigator.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SafariServices
import MessageUI

protocol Navigatable {
    var navigator: INavigator { get }
}

final class Navigator: NSObject, INavigator {

    func get(scene: NavigatorScene) -> UIViewController {
        switch scene {
        case .intro(let viewModel):return IntroViewController(vm: viewModel)
        case .login(let viewModel):return LoginViewController(vm: viewModel)
        case .verify(let viewModel):return VerifyViewController(vm: viewModel)
        case .main(let viewModel):return MainTabBarController(vm: viewModel)
        case .notifications(let viewModel):return NotificationsViewController(vm: viewModel)
        case .settings(let viewModel):return SettingsViewController(vm: viewModel)
        case .search(let viewModel):return SearchViewController(vm: viewModel)
        case .addTask(let viewModel):return AddTaskViewController(vm: viewModel)
        case .invite(let viewModel):return InviteViewController(vm: viewModel)
        case .userDetail(let viewModel):return UserDetailViewController(vm: viewModel)
        case .message(let viewModel):return MessagesViewController(vm: viewModel)
        case .help(let viewModel):return HelpViewController(vm: viewModel)
        case .privacy(let viewModel):return PrivacyViewController(vm: viewModel)
        case .terms(let viewModel):return TermsViewController(vm: viewModel)
        case .taskOverview(let viewModel):return TaskOverviewViewController(vm: viewModel)
        }
    }
    
    func present(scene: NavigatorScene) {
        let target = get(scene: scene)
        currentVC()?.present(target, animated: true, completion: { })
    }

    func dismiss() {
        currentVC()!.navigationController?.dismiss(animated: true, completion: nil)
    }

    func push(scene: NavigatorScene) {
        let target = get(scene: scene)
        push(target: target)
        
    }

    func push(target: UIViewController) {
        currentVC()?.navigationController?.pushViewController(target, animated: true)
    }
 
    func pop(toRoot: Bool = false) {
        if toRoot {
            currentVC()?.navigationController?.popToRootViewController(animated: true)
        } else {
            currentVC()?.navigationController?.popViewController(animated: true)
        }
    }
    
    func switchRoot(keyWindow: UIWindow, scene: NavigatorScene) {
        var target = get(scene: scene)
        
        if target is MainTabBarController {
            
        } else if target is IntroViewController {
            let nav = MainNavigationController(rootViewController: target)
            //Hide NavigationBar
            nav.navigationBar.isHidden = true
            target = nav
        } else {
            assertionFailure("Currently Navigator.switchRoot can only accept .main and .intro")
            Logger.log("Currently Navigator.switchRoot can only accept .main and .intro", .debug)
        }
        
        keyWindow.rootViewController = target
        keyWindow.makeKeyAndVisible()
            
    }
    
    private func currentVC(
        base: UIViewController? =
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentVC(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentVC(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentVC(base: presented)
        }
        return base
    }

}
