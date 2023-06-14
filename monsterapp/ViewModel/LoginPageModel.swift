//
//  LoginPageModel.swift
//  monsterapp
//
//  Created by Anish Somani on 10/06/2023.
//

import SwiftUI

struct User {
    let email: String
    let password: String
}

class UserDatabase {
    static var users = [
        User(email: "anish.somani@branch.io", password: "Proserve"),
        User(email: "gareth.evans@branch.io", password: "Proserve"),
        User(email: "oshpilev@branch.io", password: "Proserve"),
        User(email: "proserve.test@branch.io", password: "Proserve"),
        User(email: "Proserve.test@branch.io", password: "Proserve"),
        User(email: "", password: ""),
        User(email: " ", password: " ")
    ]
    
    static func getUser(email: String) -> User? {
        return users.first(where: { $0.email == email })
    }
    
    static func addUser(email: String, password: String) {
        users.append(User(email: email, password: password))
    }
}

class LoginPageModel: ObservableObject {

    init(registerUser: Bool = false) {
        self.registerUser = registerUser
    }

    // Login Properties..
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false

    // Register Properties
    @Published var registerUser: Bool
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false

    // Log Status...
    @AppStorage("log_Status") var log_Status: Bool = false

    // Login Call...
    func Login(){
        // Do Action Here...
        guard let user = UserDatabase.getUser(email: email) else {
            return
        }
        withAnimation{
            if user.password == password {
                loggedInUserName = email
                log_Status = true
                print(log_Status)
            }
        }
    }
    
    func Logout(){
        loggedInUserName = nil
        log_Status = false
        print(log_Status)
    }

    func Register(){
        // Do Action Here...
        guard !password.isEmpty else {
            return
        }
        withAnimation{
            UserDatabase.addUser(email: email, password: password)
            loggedInUserName = email
            log_Status = true
        }
    }

    func loginAsGuest() {
        log_Status = true
    }
    func ForgotPassword(){
        // Do Action Here...
    }

    var loggedInUserName: String? {
        get {
            UserDefaults.standard.string(forKey: "loggedInUserEmail")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "loggedInUserEmail")
        }
    }
}
     
