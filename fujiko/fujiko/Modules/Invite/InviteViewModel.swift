//
//  InviteViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class InviteViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    
    struct Input {
        let searchInputed: BehaviorRelay<String>
        let cellTapped: PublishSubject<IndexPath>
    }
        
    struct Output {
        let members: BehaviorRelay<[InviteCellViewModel]>
        let refreshing: BehaviorRelay<Bool>
    }
    
    let input = Input(searchInputed: BehaviorRelay<String>(value: ""),
                      cellTapped: PublishSubject<IndexPath>())
    
    let output = Output(members: BehaviorRelay<[InviteCellViewModel]>(value: []),
                        refreshing: BehaviorRelay<Bool>(value: false))
      
    override init() {
        super.init()
        
        input.searchInputed
            .do(onNext: { _ in self.output.refreshing.accept(true) })
            .flatMapLatest { text in self.apiService.getAllMember(keyword: text) }
            .do(onNext: { _ in self.output.refreshing.accept(false) })
            .map { $0.code == .ok ? $0.data ?? [] : [] }
            .map { $0.map { InviteCellViewModel(user: $0, isInviting: false) }}
            .asDriver(onErrorJustReturn: [])
            .drive(output.members)
            .disposed(by: disposeBag)
        
        input.cellTapped
            .subscribe(onNext: { [unowned self] (indexPath) in
                let cellVM = self.output.members.value[indexPath.row]
                cellVM.isInviting.accept(!(cellVM.isInviting.value))
            })
            .disposed(by: disposeBag)
    }

}
