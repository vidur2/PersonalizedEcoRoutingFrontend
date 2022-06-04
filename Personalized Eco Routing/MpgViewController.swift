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
        print("loaded!")
        showForm()
        print("Showing")
    }
    
    func addSuperView(view: UIViewController) {
        self.superView = view;
    }

    func showForm() {
        submitButton = UIButton()
        textField = UITextField();

        submitButton.setTitle("Submit", for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.backgroundColor = .blue
        submitButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)


        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        view.addSubview(submitButton)
        view.addSubview(textField)
        view.setNeedsLayout()
    }

    @IBAction func submitForm() {
        if let floatValue = Float(textField.text!) {
            let session = BackendInter()
            let manager = StateManager(viewController: self.superView, initState: State.loginVc)
            session.createUser(fuelEff: floatValue)
            manager.transition(to: State.mapVc)

        } else {
            textField.text = ""
        }

    }
}
