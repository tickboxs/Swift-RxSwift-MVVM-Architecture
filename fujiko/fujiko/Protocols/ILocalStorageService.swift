//
//  ILocalStorageService.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ILocalStorageService {
    
    func setValueFor<T>(key: String, value: T)
    func getValueFor(key: String) -> Any?
    func isKeyExist(key: String) -> Bool
    func removeValueFor(key: String)
    
}
