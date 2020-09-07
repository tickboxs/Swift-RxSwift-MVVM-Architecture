//
//  ApiServiceStub.swift
//  fujiko
//
//  Created by Charlie Cai on 21/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ApiServiceStub: IApiService {
    
    func login(email: String, password: String) -> Observable<HttpResponse<User>> {
        if email == Configs.USER_EMAIL && password == Configs.USER_PASSWORD {
            return Observable.just(HttpResponse<User>(code: HttpCode.ok,
            data: User(role: "DEVELOPER",
                       team: "MOBILE TEAM",
                       email: EmailPW(email: "cai.charlie@hotmail.com"),
                       avatar: "JOJO",
                       status: .active,
                       signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336)),
            errorMessage: nil))
            
        } else {
            return Observable.just(HttpResponse<User>(code: HttpCode.error,
            data: nil,
            errorMessage: R.string.i18n.email_or_password_wrong()))
        }
    }
    
    func signUp(email: String, password: String, name: String) -> Observable<HttpResponse<User>> {
        return Observable.just(HttpResponse<User>(code: HttpCode.ok,
        data: nil,
        errorMessage: nil))
    }
    
    func getAllProjects() -> Observable<HttpResponse<[Project]>> {
        let projects = [
                Project(name: "", memebers: [], description: "", tasks: []),
                Project(name: "", memebers: [], description: "", tasks: [])
            ]
        return Observable.just(HttpResponse<[Project]>(code: HttpCode.ok, data: projects, errorMessage: ""))
    }
    
    func getAllTasks(keyword: String) -> Observable<HttpResponse<[Task]>> {
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
        return Observable.just(HttpResponse<[Task]>(code: HttpCode.ok,
                data: tasks.filter {
                   keyword == "" ? true :
                   ($0.name ?? "").contains(keyword) ? true : false},
                errorMessage: ""))
    }
    
    func getLocalUserProfile() -> Observable<User> {
        let user = User(role: "Developer",
                        team: "Mobile Team",
                        email: EmailPW(email: "cai.charlie@hotmail.com"),
                        avatar: "1231e231",
                        status: .active,
                        signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336))
        return .just(user)
    }
    
    func getAllNotifications() -> Observable<HttpResponse<[Notification]>> {
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
        return Observable.just(HttpResponse<[Notification]>(code: HttpCode.ok,
                                                            data: notifications,
                                                            errorMessage: ""))

    }
    
    func getAllStatistics(statisticsStatus: StatisticsStatus) -> Observable<HttpResponse<[Statistics]>> {
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
        
        return Observable.just(HttpResponse<[Statistics]>(code: HttpCode.ok,
                                                            data: statisticses.filter {
                                                             $0.status == statisticsStatus },
                                                            errorMessage: ""))

    }
    
    func getAllMember(keyword: String) -> Observable<HttpResponse<[User]>> {
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
        
        return Observable.just(HttpResponse<[User]>(code: HttpCode.ok, data: memebers, errorMessage: ""))

    }
    
    func getUserDetail(userId: Int) -> Observable<HttpResponse<User>> {
        let user = User(role: "Designer",
                        team: "UI Team",
                        email: EmailPW(email: "designer.ui@ui8.com"),
                        avatar: "dadda",
                        status: .active,
                        signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336))
        return Observable.just(HttpResponse<User>(code: HttpCode.ok, data: user, errorMessage: ""))
    }
    
}
