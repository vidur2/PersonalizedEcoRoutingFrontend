//
//  ConfigState.swift
//  Personalized Eco Routing
//
//  Created by Vidur Modgil on 5/31/22.
//

import GoogleSignIn

class ConfigManager {
    let signInConfig = GIDConfiguration(clientID: "123306351755-0091g2rnbp8oj1qftb7lov56e6o5kl4b.apps.googleusercontent.com")
    
    static let shared = ConfigManager(state: false)
    
    private var signedIn: Bool = false
    private var idToken: String?
    private var emailAddress: String?
    
    public var locationArray: Array<LocationCoord> = []
    
    public func setSignInState(state: Bool) {
        self.signedIn = state
    }
    
    public func getSignInState() -> Bool {
        return self.signedIn
    }
    
    public func setIdToken(token: String?) {
        self.idToken = token
    }
    
    public func getIdToken() -> String? {
        return self.idToken
    }
    
    public func setEmailAddress(email: String?) {
        self.emailAddress = email
    }
    
    public func getEmailAddress() -> String? {
        return self.emailAddress
    }
    
    public init(state: Bool) {
        self.signedIn = state
    }
}
