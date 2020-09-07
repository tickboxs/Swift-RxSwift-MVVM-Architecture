//
//  ApiService.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

private let DELAY = DispatchTimeInterval.seconds(1)

class ApiService: NSObject, IApiService {
    
    let localStorageService = Container.shared.resolve(ILocalStorageService.self)
    
    func login(email: String, password: String) -> Observable<HttpResponse<User>> {
        return Observable<HttpResponse<User>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                if email == Configs.USER_EMAIL && password == Configs.USER_PASSWORD {
                    observer.onNext(HttpResponse<User>(code: HttpCode.ok,
                                                       data: User(role: "DEVELOPER",
                                                                  team: "MOBILE TEAM",
                                                                  email: EmailPW(email: "cai.charlie@hotmail.com"),
                                                                  avatar: "JOJO",
                                                                  status: .active,
                                                                  chat: true,
                                                                  call: true,
                                                                  signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336)),
                                                       errorMessage: nil))
                    observer.onCompleted()
                } else { observer.onNext(HttpResponse<User>(code: HttpCode.error,
                                                            data: nil,
                                                            errorMessage: R.string.i18n.email_or_password_wrong()))
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    func signUp(email: String, password: String, name: String) -> Observable<HttpResponse<User>> {
        return Observable<HttpResponse<User>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                observer.onNext(HttpResponse<User>(code: HttpCode.ok,
                                                   data: nil,
                                                   errorMessage: nil))
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
   func getAllProjects() -> Observable<HttpResponse<[Project]>> {
        
        return Observable<HttpResponse<[Project]>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                let projects = [
                        Project(name: "", memebers: [], description: "", tasks: []),
                        Project(name: "", memebers: [], description: "", tasks: [])
                    ]
                observer.onNext(HttpResponse<[Project]>(code: HttpCode.ok, data: projects, errorMessage: ""))
                   observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getAllTasks(keyword: String = "") -> Observable<HttpResponse<[Task]>> {
        return Observable<HttpResponse<[Task]>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                let tasks = [
                    Task(name: "Daily Meeting",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting1",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting2",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting3",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting4",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting5",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting6",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting7",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting8",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting9",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting10",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting11",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Task(name: "Daily Meeting12",
                         timestamp: UnixTimestampPW(timestamp: 1583859791336))]
                observer.onNext(HttpResponse<[Task]>(code: HttpCode.ok,
                                                     data: tasks.filter {
                                                        keyword == "" ? true :
                                                        ($0.name ?? "").contains(keyword) ? true : false},
                                                     errorMessage: ""))
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getLocalUserProfile() -> Observable<User> {
        
//        let user = localStorageService.getValueFor<String>(key: "user")
        let user = User(role: "Developer",
                        team: "Mobile Team",
                        email: EmailPW(email: "cai.charlie@hotmail.com"),
                        avatar: "1231e231",
                        status: .active,
                        signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336))
        return .just(user)
    }
    
    func getAllNotifications() -> Observable<HttpResponse<[Notification]>> {
        return Observable<HttpResponse<[Notification]>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                let notifications = [
                    Notification(userId: 0,
                                 userImage: "image",
                                 userName: "Matt",
                                 taskName: "Web Redesign V2.0",
                                 action: "started",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 1,
                                 userImage: "image",
                                 userName: "Liam",
                                 taskName: "Daily Scrum Meeting",
                                 action: "added",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 2,
                                 userImage: "image",
                                 userName: "Matt",
                                 taskName: "Web Redesign V2.0",
                                 action: "added a checklist to",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 3,
                                 userImage: "image",
                                 userName: "Lauren",
                                 taskName: "Website redesign v1.0",
                                 action: "moved",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 4,
                                 userImage: "image",
                                 userName: "Brian",
                                 taskName: "Website redesign v2.0",
                                 action: "watched",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 5,
                                 userImage: "image",
                                 userName: "Liam",
                                 taskName: "Moodboard Ideas",
                                 action: "added",
                                timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 6,
                                 userImage: "image",
                                 userName: "Lauren",
                                 taskName: "Website redesign v2.0",
                                 action: "added a check list",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336)),
                    Notification(userId: 7,
                                 userImage: "image",
                                 userName: "Lauren",
                                 taskName: "Fix bug on dashboard ",
                                 action: "moved",
                                 timestamp: UnixTimestampPW(timestamp: 1583859791336))]
                
                observer.onNext(HttpResponse<[Notification]>(code: HttpCode.ok,
                                                             data: notifications,
                                                             errorMessage: ""))
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getAllStatistics(statisticsStatus: StatisticsStatus) -> Observable<HttpResponse<[Statistics]>> {
        
        return Observable<HttpResponse<[Statistics]>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                
                let random_range: UInt32 = 20
                
                let statisticses = [
                    Statistics(weekday: .monday,
                               percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                               status: .in_progress),
                Statistics(weekday: .tuesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_progress),
                Statistics(weekday: .wednesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_progress),
                Statistics(weekday: .thursday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_progress),
                Statistics(weekday: .friday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_progress),
                Statistics(weekday: .saturday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_progress),
                Statistics(weekday: .sunday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_progress),
                Statistics(weekday: .monday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .tuesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .wednesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .thursday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .friday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .saturday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .sunday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .completed),
                Statistics(weekday: .monday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .tuesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .wednesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .thursday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .friday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .saturday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .sunday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .to_do),
                Statistics(weekday: .monday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review),
                Statistics(weekday: .tuesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review),
                Statistics(weekday: .wednesday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review),
                Statistics(weekday: .thursday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review),
                Statistics(weekday: .friday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review),
                Statistics(weekday: .saturday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review),
                Statistics(weekday: .sunday,
                           percentage: PercentagePW(percentage: Float(arc4random() % random_range)),
                           status: .in_review)]
                observer.onNext(HttpResponse<[Statistics]>(code: HttpCode.ok,
                                                           data: statisticses.filter {
                                                            $0.status == statisticsStatus },
                                                           errorMessage: ""))
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getAllMember(keyword: String = "") -> Observable<HttpResponse<[User]>> {
        
        return Observable<HttpResponse<[User]>>.create { (observer) -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DELAY, execute: {
                
                let memebers = [
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "cai.charlie@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "cai.charlie@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "yilin.li@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "kairong.chen@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "kairong.chen@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "chunqiang.cai@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "baidu.123@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "google@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "k@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) ),
                    User(role: "Developer",
                         team: "UI Team",
                         email: EmailPW(email: "k@hotmail.com"),
                         avatar: "1232131",
                         status: .inactive,
                         signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336) )]
                    .filter { (user) -> Bool in
                        if keyword == "" {
                            return true
                        } else {
                            return (user.role ?? "").contains(keyword) ||
                                (user.team ?? "").contains(keyword) ||
                                (user.email ?? "").contains(keyword)
                        }
                    }
            
                observer.onNext(HttpResponse<[User]>(code: HttpCode.ok, data: memebers, errorMessage: ""))
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getUserDetail(userId: Int) -> Observable<HttpResponse<User>> {
        return Observable.create { (observer) -> Disposable in
            let user = User(role: "Designer",
                            team: "UI Team",
                            email: EmailPW(email: "designer.ui@ui8.com"),
                            avatar: "dadda",
                            status: .active,
                            signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336))
            observer.onNext(HttpResponse<User>(code: HttpCode.ok, data: user, errorMessage: ""))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
