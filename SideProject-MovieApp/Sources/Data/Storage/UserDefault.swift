//
//  UserDefault.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/08.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    private(set) var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            return self.container.object(forKey: self.key) as? Value ?? self.defaultValue
        }
        set {
            print("UserDefault set '\(self.key) to \(newValue)")
            self.container.set(newValue, forKey: self.key)
        }
    }
}

struct UserDefaultManager {
    @UserDefault(key: "userId", defaultValue: nil)
    static var userId: String?
    
    @UserDefault(key: "password", defaultValue: nil)
    static var password: String?
    
    @UserDefault(key: "userName", defaultValue: nil)
    static var userName: String?
    
    @UserDefault(key: "nickname", defaultValue: nil)
    static var nickname: String?
    
    @UserDefault(key: "sns_type", defaultValue: nil)
    static var snsType: String?
    
    @UserDefault(key: "agency", defaultValue: nil)
    static var agency: String?
    
    @UserDefault(key: "mbti", defaultValue: nil)
    static var mbti: String?
    
    @UserDefault(key: "phoneNumber", defaultValue: nil)
    static var phoneNumber: String?
    
    @UserDefault(key: "lastNicknameChangeDate", defaultValue: nil)
    static var lastNicknameChangeDate: String?
    
}
