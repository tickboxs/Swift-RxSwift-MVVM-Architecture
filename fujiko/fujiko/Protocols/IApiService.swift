//
//  IApiService.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import RxSwift
import RxCocoa

protocol IApiService {
    func login(email: String, password: String) -> Observable<HttpResponse<User>>
    func signUp(email: String, password: String, name: String) -> Observable<HttpResponse<User>>
    func getAllProjects() -> Observable<HttpResponse<[Project]>>
    func getAllTasks(keyword: String) -> Observable<HttpResponse<[Task]>>
    func getLocalUserProfile() -> Observable<User>
    func getAllNotifications() -> Observable<HttpResponse<[Notification]>>
    func getAllStatistics(statisticsStatus: StatisticsStatus) -> Observable<HttpResponse<[Statistics]>>
    func getAllMember(keyword: String) -> Observable<HttpResponse<[User]>>
    func getUserDetail(userId: Int) -> Observable<HttpResponse<User>>
}
