//
//  SettingsCellViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct SettingsCellViewModel {
    let title: String
    let on: Bool?
    
    var bibindingRelay: BehaviorRelay<Bool>?
}
