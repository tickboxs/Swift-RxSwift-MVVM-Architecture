//
//  INavigator.swift
//  fujiko
//
//  Created by Charlie Cai on 14/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

enum NavigatorScene {
    case intro(viewModel: IntroViewModel)
    case login(viewModel: LoginViewModel)
    case verify(viewModel: VerifyViewModel)
    case main(viewModel: MainTabBarViewModel)
    case notifications(viewModel: NotificationsViewModel)
    case settings(viewModel: SettingsViewModel)
    case search(viewModel: SearchViewModel)
    case addTask(viewModel: AddTaskViewModel)
    case invite(viewModel: InviteViewModel)
    case userDetail(viewModel: UserDetailViewModel)
    case message(viewModel: MessagesViewModel)
    case help(viewModel: HelpViewModel)
    case privacy(viewModel: PrivacyViewModel)
    case terms(viewModel: TermsViewModel)
    case taskOverview(viewModel: TaskOverviewViewModel)
}

protocol INavigator: AutoMockable {
    
    func get(scene: NavigatorScene) -> UIViewController
    
    func present(scene: NavigatorScene)
    func dismiss()

    func push(scene: NavigatorScene)
    func pop(toRoot: Bool)
    
    func switchRoot(keyWindow: UIWindow, scene: NavigatorScene)
}
