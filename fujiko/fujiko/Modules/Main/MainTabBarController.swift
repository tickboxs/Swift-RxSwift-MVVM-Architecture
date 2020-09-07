//
//  MainTabBarController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import YYKit

// Tag for VCs
private enum TabTag: Int {
    case dashboard = 0
    case statistics = 1
    case addTask = 2
    case calendar = 3
    case profile = 4
}

final class MainTabBarController: TabBarController {
    
    override func makeUI() {
        
        // DashboardVC
        let dashboardVC = DashboardViewController(vm: DashboardViewModel())
        let wrappedDashboardVC = MainNavigationController(rootViewController: dashboardVC)
        wrappedDashboardVC.tabBarItem = UITabBarItem(title: R.string.i18n.dashboard(),
                                                     image: R.image.dashboard(),
                                                     tag: TabTag.dashboard.rawValue)
        
        // StatisticsVC
        let statisticsVC = StatisticsViewController(vm: StatisticsViewModel())
        let wrappedStatisticsVC = MainNavigationController(rootViewController: statisticsVC)
        wrappedStatisticsVC.tabBarItem = UITabBarItem(title: R.string.i18n.statistics(),
                                                      image: R.image.statistics(),
                                                      tag: TabTag.statistics.rawValue)
        
        // Add Project Button
        let addProjectVC = AddProjectViewController(vm: AddProjectViewModel())
        addProjectVC.tabBarItem = UITabBarItem(title: "",
                                               image: R.image.add()?.withRenderingMode(.alwaysOriginal),
                                               tag: TabTag.addTask.rawValue)
        
        // CalendarVC
        let calendarVC = CalendarViewController(vm: CalendarViewModel())
        let wrappedCalendarVC = MainNavigationController(rootViewController: calendarVC)
        wrappedCalendarVC.tabBarItem = UITabBarItem(title: R.string.i18n.calendar(),
                                                    image: R.image.calendar(),
                                                    tag: TabTag.calendar.rawValue)
        
        // ProfileVC
        let profileVC = ProfileViewController(vm: ProfileViewModel())
        let wrappedProfileVC = MainNavigationController(rootViewController: profileVC)
        wrappedProfileVC.tabBarItem = UITabBarItem(title: R.string.i18n.profile(),
                                                   image: R.image.profile(),
                                                   tag: TabTag.profile.rawValue)
        
        self.viewControllers = [wrappedDashboardVC,
                                wrappedStatisticsVC,
                                addProjectVC,
                                wrappedCalendarVC,
                                wrappedProfileVC]
        
        // Set Button selected and unselected color
        tabBar.tintColor = UIColor(Theme.Color.tabbarSelectedColor)
        tabBar.unselectedItemTintColor = UIColor(Theme.Color.tabbarUnselectedColor)
        
        // Remove Black line at the top of the tabbar
        tabBar.shadowImage = UIImage(color: UIColor(Theme.Color.background_light)!)
        tabBar.backgroundImage = UIImage(color: UIColor(Theme.Color.background_light)!)
        
        self.delegate = self
    }

}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
        // 如果是加号按钮 则不跳转
        if viewController.tabBarItem.tag == TabTag.addTask.rawValue {
            
            let addProjectVC = MainNavigationController(
                rootViewController: AddProjectViewController(vm: AddProjectViewModel()))
            
            self.present(addProjectVC, animated: true) {
                
            }
            return false
        } else {
            return true
        }
    }

}
