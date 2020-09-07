//
//  LifecycleAwarable.swift
//  fujiko
//
//  Created by Charlie Cai on 26/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

// IMPORTANT!!!
// Here I learn from Lifecycle observer from android jetpack
// With ViewModel LifecycleAwarable,we no longer need to write
// life cycle related business logic codes in ViewController

protocol LifecycleAwarable {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}
