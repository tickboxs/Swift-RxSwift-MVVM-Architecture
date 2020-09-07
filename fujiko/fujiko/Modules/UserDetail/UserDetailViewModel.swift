//
//  UserDetailViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class UserDetailViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    private let systemService = Container.shared.resolve(ISystemService.self)!
    
    struct Input {
        let loadUserDetailItemsStarted: PublishRelay<Int>
        let chatTapped: PublishSubject<Void>
        let callTapped: PublishSubject<Void>
    }
    
    struct Output {
        let userDetailItems: BehaviorRelay<[UserDetailCellViewModel]>
    }
    
    let input = Input(loadUserDetailItemsStarted: PublishRelay<Int>(),
                      chatTapped: PublishSubject<Void>(),
                      callTapped: PublishSubject<Void>())
    let output = Output(userDetailItems: BehaviorRelay<[UserDetailCellViewModel]>(value: []))
    
    init(userId: Int) {
        super.init()
        
        input.chatTapped
            .subscribe(onNext: { [unowned self] _ in
                self.navigator.push(scene: .message(viewModel: MessagesViewModel()))
            })
            .disposed(by: disposeBag)
        
        input.callTapped
            .subscribe(onNext: { [unowned self] _ in
                self.systemService.call(number: Configs.USER_PHONE)
            })
            .disposed(by: disposeBag)
        
        input.loadUserDetailItemsStarted
            .flatMapLatest { userId in self.apiService.getUserDetail(userId: userId) }
            .map { (response) -> User? in
            if response.code == .ok {
                return response.data
            } else {
                return nil
            }
        }.map { (user) -> [UserDetailCellViewModel] in
            
            if let user = user {
                return self.createUserDetailCellItems(user: user)
            } else {
                return []
            }
            
            }.asDriver(onErrorJustReturn: [])
            .drive(output.userDetailItems)
            .disposed(by: disposeBag)
        
        input.loadUserDetailItemsStarted.accept(userId)
        
    }
    
    private func createUserDetailCellItems(user: User) -> [UserDetailCellViewModel] {
        
        let roleCellViewModel =
            UserDetailCellViewModel(topText: R.string.i18n.role(),
                                    bottomText: user.role ?? "")
        let teamCellViewModel =
            UserDetailCellViewModel(topText: R.string.i18n.team(),
                                    bottomText: user.team ?? "")
        let statusCellViewModel =
            UserDetailCellViewModel(topText: R.string.i18n.status(),
                                    bottomText: "inactyive")
        let sinceCellViewModel =
            UserDetailCellViewModel(
                topText: R.string.i18n.member_since(),
                bottomText: Date.timeIntervalChangeToTimeStr(
                    timeInterval: user.signUpTimestamp ?? 0,
                    dateFormat: nil))
        return [roleCellViewModel, teamCellViewModel, statusCellViewModel, sinceCellViewModel]
    }
    
}
