
import Foundation

class UserSessionManager {
    static let shared = UserSessionManager()
    
    private let loggedInUserEmailKey = "LoggedInUserEmail"
    private let loggedInUserRoleKey = "LoggedInUserRole"
    private let loggedInUserName = "LoggedInUserName"
    private let loggedInUserInterestsKey = "LoggedInUserInterests"
    private init() {} // Prevent instantiation from outside
    
    // Store the email and role of the logged-in user
    func setLoggedInUser(email: String, role: String, name: String, userInterests: [String]) {
        UserDefaults.standard.set(email, forKey: loggedInUserEmailKey)
        UserDefaults.standard.set(role, forKey: loggedInUserRoleKey)
        UserDefaults.standard.set(name, forKey: loggedInUserName)
        UserDefaults.standard.set(userInterests, forKey: loggedInUserInterestsKey)
    }
    
    func setLoggedInUserInterests(userInterests: [String]) {
        UserDefaults.standard.set(userInterests, forKey: loggedInUserInterestsKey)
    }

    func getLoggedInUserInterests() -> [String] {
        return UserDefaults.standard.stringArray(forKey: loggedInUserInterestsKey) ?? []
    }
    // Retrieve the email of the logged-in user
    func getLoggedInUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: loggedInUserEmailKey)
    }
    
    // Retrieve the role of the logged-in user
    func getLoggedInUserRole() -> String? {
        return UserDefaults.standard.string(forKey: loggedInUserRoleKey)
    }
    
    func getLoggedInUserName() -> String? {
        return UserDefaults.standard.string(forKey: loggedInUserName)
    }
    
    // Clear the logged-in user's email and role (e.g., during logout)
    func clearLoggedInUserSession() {
        UserDefaults.standard.removeObject(forKey: loggedInUserEmailKey)
        UserDefaults.standard.removeObject(forKey: loggedInUserRoleKey)
        UserDefaults.standard.removeObject(forKey: loggedInUserName)
        
    }
}


