//
//  ViewController.swift
//  Personalized Eco Routing
//
//  Created by Vidur Modgil on 5/24/22.
//


// #-code-snippet: navigation dependencies-swift
import MapboxMaps
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Turf
//import GoogleSignIn

// #-end-code-snippet: navigation dependencies-swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let stateManager = StateManager(viewController: self, initState: State.loading)
        if ConfigManager.shared.getSignInState() {
            stateManager.transition(to: State.mapVc)
        } else {
            stateManager.transition(to: State.loginVc)
        }
    }
}
