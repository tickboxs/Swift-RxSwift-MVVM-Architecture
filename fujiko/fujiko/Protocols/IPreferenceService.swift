//
//  IPreference.swift
//  fujiko
//
//  Created by Charlie Cai on 23/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol IPreferenceService {
    var chatRelay: BehaviorRelay<Bool> { get set }
    var callRelay: BehaviorRelay<Bool> { get set}
    var remindersRelay: BehaviorRelay<Bool> { get set}
    var notificationsRelay: BehaviorRelay<Bool> { get set}
    var darkModeRelay: BehaviorRelay<Bool> { get set}
}
