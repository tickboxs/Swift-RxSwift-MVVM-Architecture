//
//  ProfileCellViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ProfileCellViewModel {
    
    let topText: String?
    let centerText: String?
    let bottomText: String?
    let switchStatus: Bool?
    
    var bibindRelay: BehaviorRelay<Bool>?
}
