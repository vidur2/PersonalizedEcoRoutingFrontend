//
//  MpgViewController.swift
//  Personalized Eco Routing
//
//  Created by Vidur Modgil on 6/2/22.
//

import Foundation
import UIKit


class MpgViewController: UIViewController {

    var textField: UITextField!;
    var submitButton: UIButton!;
    var superView: UIViewController!;

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("loaded!")
        showForm()
        print("Showing")
    }
    
    func addSuperView(view: UIViewController) {
        self.superView = view;
    }

    func showForm() {
        
        submitButton = UIButton()
        submitButton.setTitle("Done", for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitleColor(.systemBlue, for: .normal)
        
        textField = UITextField()
        
        textField.placeholder = "MPG of Car"
        textField.sizeToFit()

        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        
        view.addSubview(submitButton)
        view.addSubview(textField)
        
        // Centers text field
        textField.center = self.view.center;
        
        // Positions button
        submitButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        submitButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        
        
        view.setNeedsLayout()
    }

    @IBAction func submitForm() {
        if let floatValue = Float(textField.text!) {
            let session = BackendInter()
            let manager = StateManager(viewController: self.superView, initState: State.loginVc)
            print(String(decoding: session.createUser(fuelEff: floatValue)!, as: UTF8.self))
            manager.transition(to: State.mapVc)
            self.dismiss(animated: true)

        } else {
            textField.text = ""
        }

    }
}
