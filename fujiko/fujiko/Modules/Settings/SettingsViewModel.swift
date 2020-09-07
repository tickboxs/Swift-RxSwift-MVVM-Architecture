//
//  SettingsViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class SettingsViewModel: ViewModel, ViewModelType {
    
    private let localStorageService = Container.shared.resolve(ILocalStorageService.self)!
    private let preferenceService = Container.shared.resolve(IPreferenceService.self)!
    
    struct Input {
        let logoutTapped: PublishSubject<Void>
        let tableViewItemsTapped: PublishSubject<IndexPath>
    }
    
    struct Output {
        let settingsItems: BehaviorRelay<[SettingsCellViewModel]>
    }
    
    let input = Input(logoutTapped: PublishSubject<Void>(),
                      tableViewItemsTapped: PublishSubject<IndexPath>())
    let output = Output(settingsItems: BehaviorRelay<[SettingsCellViewModel]>(value: []))
    
    override init() {
        super.init()
        
        input.logoutTapped
            .subscribe(onNext: { [unowned self] _ in
                self.localStorageService.removeValueFor(key: Configs.KEY_USER)
                if let keyWindow = UIWindow.keyWindow {
                    self.navigator.switchRoot(keyWindow: keyWindow, scene: .intro(viewModel: IntroViewModel()))
                } else {
                    Logger.log("Could not get KeyWindow", .error)
                }

            })
            .disposed(by: disposeBag)
        
        input.tableViewItemsTapped
            .subscribe(onNext: { [unowned self] (indexPath) in
                switch indexPath.row {
                case 3:// Help
                    self.navigator.push(scene: .help(viewModel: HelpViewModel()))
                case 4:// Privacy
                    self.navigator.push(scene: .privacy(viewModel: PrivacyViewModel()))
                case 5:// Terms
                    self.navigator.push(scene: .terms(viewModel: TermsViewModel()))
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
        
        let settingsItemViewModel = getSettingsCellViewModels()
        output.settingsItems.accept(settingsItemViewModel)
        
    }
    
    private func getSettingsCellViewModels() -> [SettingsCellViewModel] {
        return [
            SettingsCellViewModel(title: R.string.i18n.reminders(),
                                  on: true,
                                  bibindingRelay: preferenceService.remindersRelay),
            SettingsCellViewModel(title: R.string.i18n.notifications(),
                                  on: true,
                                  bibindingRelay: preferenceService.notificationsRelay),
            SettingsCellViewModel(title: R.string.i18n.dark_mode(),
                                  on: false,
                                  bibindingRelay: preferenceService.darkModeRelay),
            SettingsCellViewModel(title: R.string.i18n.help(), on: nil),
            SettingsCellViewModel(title: R.string.i18n.privacy(), on: nil),
            SettingsCellViewModel(title: R.string.i18n.terms_conditions(), on: nil)
        ]
    }
}
