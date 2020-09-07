//
//  DIContainer.swift
//  fujiko
//
//  Created by Charlie Cai on 14/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import Swinject

extension Container {
    
    public static let shared = Container()
    
    public static func registerAll() {
        
        // Check if in Unit Test Project
        if NSClassFromString("XCTest") != nil {
            // inObjectScope(.container) means singleton
            shared.register(INavigator.self) { _ in Navigator() }.inObjectScope(.container)
            shared.register(IApiService.self) { _ in ApiServiceStub() }.inObjectScope(.container)
            shared.register(ISystemService.self) { _ in SystemService() }.inObjectScope(.container)
            shared.register(ILocalStorageService.self) { _ in LocalStorageService() }.inObjectScope(.container)
            shared.register(IPreferenceService.self) { _ in PreferenceService() }.inObjectScope(.container)
        } else {
            // inObjectScope(.container) means singleton
            shared.register(INavigator.self) { _ in Navigator() }.inObjectScope(.container)
            shared.register(IApiService.self) { _ in ApiService() }.inObjectScope(.container)
            shared.register(ISystemService.self) { _ in SystemService() }.inObjectScope(.container)
            shared.register(ILocalStorageService.self) { _ in LocalStorageService() }.inObjectScope(.container)
            shared.register(IPreferenceService.self) { _ in PreferenceService() }.inObjectScope(.container)
        }
        
    }
    
}
