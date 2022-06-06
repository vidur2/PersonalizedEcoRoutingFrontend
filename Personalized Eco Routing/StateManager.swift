//
//  StateManager.swift
//  Personalized Eco Routing
//
//  Created by Vidur Modgil on 6/1/22.
//

import Foundation
import UIKit

enum State {
    case mapVc
    case loginVc
    case loading
}

class StateManager {
    
    let viewController: UIViewController
    
    private var currentState: State = State.loginVc

    
    private let containedViewControllers: [State: UIViewController] = [
      .mapVc: MapViewController(),
      .loginVc: LoginViewController(),
      .loading: ViewController()
    ]
    
    func transition(to state: State) {
      // Remove current vc
      let currentVc = containedViewControllers[currentState]
      if currentVc?.parent != nil {
        currentVc?.willMove(toParent: nil)
        currentVc?.view.removeFromSuperview()
        currentVc?.removeFromParent()
      }

        // Add new vc
        guard let newVc = containedViewControllers[state] else { return }
        self.currentState = state
        self.viewController.addChild(newVc)
        self.viewController.view.addSubview(newVc.view)
        newVc.didMove(toParent: self.viewController)
    }
    
    init(viewController: UIViewController, initState: State) {
        self.viewController = viewController
        self.currentState = initState
    }
}
