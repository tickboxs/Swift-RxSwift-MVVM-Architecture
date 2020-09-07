//
//  PreferenceService.swift
//  fujiko
//
//  Created by Charlie Cai on 23/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject
import SwiftyJSON

class PreferenceService: IPreferenceService {

    private let localStorageService = Container.shared.resolve(ILocalStorageService.self)!
    private let disposeBag = DisposeBag()
    
    var chatRelay: BehaviorRelay<Bool>
    var callRelay: BehaviorRelay<Bool>
    var remindersRelay: BehaviorRelay<Bool>
    var notificationsRelay: BehaviorRelay<Bool>
    var darkModeRelay: BehaviorRelay<Bool>
    
    init() {
        
        var isChatOn = false
        var isCallOn = false
        var isRemindersOn = false
        var isNotificationsOn = false
        var isDarkModeOn = false
        
        if localStorageService.isKeyExist(key: Configs.KEY_USER) {
            
            let userJson = JSON(localStorageService.getValueFor(key: Configs.KEY_USER) as Any)
            isChatOn = userJson["chat"].boolValue
            isCallOn = userJson["call"].boolValue
            isRemindersOn = userJson["reminders"].boolValue
            isNotificationsOn = userJson["notifications"].boolValue
            isDarkModeOn = userJson["darkMode"].boolValue
   
        } else {
            Logger.log("cannot use this BehaviorRelay when userJson is not in UserDefault", .error)
        }
        
        chatRelay = BehaviorRelay(value: isChatOn)
        callRelay = BehaviorRelay(value: isCallOn)
        remindersRelay = BehaviorRelay(value: isRemindersOn)
        notificationsRelay = BehaviorRelay(value: isNotificationsOn)
        darkModeRelay = BehaviorRelay(value: isDarkModeOn)
        
        for t in
        [(chatRelay, \User.chat),
         (callRelay, \User.call),
         (remindersRelay, \User.reminders),
         (notificationsRelay, \User.notifications),
         (darkModeRelay, \User.darkMode)] {
            t.0.subscribe(onNext: { (boolValue) in
                self.UpdatePreference(writablekeyPath: t.1, value: boolValue)
            }).disposed(by: disposeBag)
        }

    }
    
    private func UpdatePreference<T>(writablekeyPath: WritableKeyPath<User, T?>, value: T?) {

        if self.localStorageService.isKeyExist(key: Configs.KEY_USER) {

            let userJson = JSON(self.localStorageService.getValueFor(key: Configs.KEY_USER) as Any)
                var user = User(json: userJson)
                user[keyPath: writablekeyPath] = value
                self.localStorageService.setValueFor(key: Configs.KEY_USER, value: user.toJSON())

            } else {
                Logger.log("cannot use this BehaviorRelay when userJson is not in UserDefault", .error)
            }
        
    }
}
