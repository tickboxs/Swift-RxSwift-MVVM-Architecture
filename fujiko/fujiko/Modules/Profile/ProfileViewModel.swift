//
//  ProfileViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class ProfileViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    private let preferenceService = Container.shared.resolve(IPreferenceService.self)!

    struct Input {
        let loadUserProfileStarted: BehaviorRelay<Void>
    }
    
    struct Output {
        let userItems: BehaviorRelay<[ProfileCellViewModel]>
    }
    
    let input = Input(loadUserProfileStarted: BehaviorRelay<Void>(value: ()))
    let output = Output(userItems: BehaviorRelay<[ProfileCellViewModel]>(value: []))
    
    override init() {
        super.init()
        
        input.loadUserProfileStarted
            .flatMapLatest { self.apiService.getLocalUserProfile() }
            .map { (user) -> [ProfileCellViewModel] in
                return self.createProfileCellItems(user: user)
            }
        .asDriver(onErrorJustReturn: [])
        .drive(output.userItems).disposed(by: disposeBag)
    
    }
    
    private func createProfileCellItems(user: User) -> [ProfileCellViewModel] {
        
        let roleCellViewModel = ProfileCellViewModel(topText: R.string.i18n.role(),
                                       centerText: nil,
                                       bottomText: user.role,
                                       switchStatus: nil)
        let teamCellViewModel = ProfileCellViewModel(topText: R.string.i18n.team(),
                                       centerText: nil,
                                       bottomText: user.team,
                                       switchStatus: nil)
        let statusCellViewModel = ProfileCellViewModel(topText: R.string.i18n.status(),
                                         centerText: nil,
                                         bottomText: user.status?.toString(),
                                         switchStatus: nil)
        let sinceCellViewModel = ProfileCellViewModel(topText: R.string.i18n.member_since(),
                                        centerText: nil,
                                        bottomText:
            Date.timeIntervalChangeToTimeStr(timeInterval: user.signUpTimestamp ?? 0, dateFormat: nil),
                                        switchStatus: nil)
        
        let chatCellViewModel = ProfileCellViewModel(topText: nil,
                                       centerText: R.string.i18n.chat(),
                                       bottomText: nil,
                                       switchStatus: true,
                                       bibindRelay: preferenceService.chatRelay)
        
        let callCellViewModel = ProfileCellViewModel(topText: nil,
                                       centerText: R.string.i18n.call(),
                                       bottomText: nil,
                                       switchStatus: true,
                                       bibindRelay: preferenceService.callRelay)
        
        return [roleCellViewModel,
                teamCellViewModel,
                statusCellViewModel,
                sinceCellViewModel,
                chatCellViewModel,
                callCellViewModel]
    }
}


