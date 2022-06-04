//
//  LoginViewController.swift
//  Personalized Eco Routing
//
//  Created by Vidur Modgil on 5/31/22.
//

import GoogleSignIn

class LoginViewController: UIViewController {
    var googleSignIn: GIDSignInButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayGIDSignIn()
    }
    
    func displayGIDSignIn() {
        googleSignIn = GIDSignInButton()
        
        // Add a title and set the button's constraints
        googleSignIn.translatesAutoresizingMaskIntoConstraints = false
        googleSignIn.center = self.view.center
        googleSignIn.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin]
        
        // Adds action
        googleSignIn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        view.addSubview(googleSignIn)
        
        // Centers button
        googleSignIn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        googleSignIn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        view.setNeedsLayout()
    }
    
    @IBAction func signIn(sender: GIDSignInButton) {
        GIDSignIn.sharedInstance.signIn(with: ConfigManager.shared.signInConfig, presenting: self) { user, error in
        guard error == nil else { return }

        // If sign in succeeded, display the app's main content View.
            user?.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }

                let idToken = authentication.idToken
                // Send ID token to backend (example below).
                let stateManager = StateManager(viewController: self, initState: State.loginVc)
                let session = BackendInter()
                ConfigManager.shared.setSignInState(state: true)
                ConfigManager.shared.setIdToken(token: idToken)
                ConfigManager.shared.setEmailAddress(email: user?.profile?.email)
                let valid = session.loadUserData()
                print(valid)
                if valid {
                    stateManager.transition(to: State.mapVc)
                } else {
                    let mpgController = MpgViewController();
                    self.present(mpgController, animated: true);
                }
            }
      }
    }
}
