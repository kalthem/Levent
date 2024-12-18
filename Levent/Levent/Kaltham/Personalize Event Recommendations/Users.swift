//
//  Users.swift
//  Levent
//
//  Created by k 3 on 12/12/2024.
//

import UIKit


import Foundation

class Users: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

enum UserType: String, Codable {
    case admin
    case organizer
    case normalUser
}

struct User {
    var username: String
    var email: String
    var phoneNumber: String
    var hashedPassword: String
    var userType: UserType
}






