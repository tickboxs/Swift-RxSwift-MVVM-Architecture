//
//  InviteCellViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class InviteCellViewModel {
    
    let email: String
    let avatar: String
    let isInviting: BehaviorRelay<Bool>
    
    init(user: User, isInviting: Bool) {
        email = user.email ?? ""
        avatar = user.avatar ?? ""
        self.isInviting = BehaviorRelay<Bool>(value: isInviting)
    }
}
