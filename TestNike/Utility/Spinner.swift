//
//  Spinner.swift
//  TestNike
//
//  Created by Manjul Shrestha on 8/5/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import Foundation
import UIKit

public class Spinner: UIViewController {
    public static let shared = Spinner()

    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override public func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    public func startSpinner(viewController: UIViewController){
        viewController.addChild(Spinner.shared)
        self.view.frame = viewController.view.frame
        viewController.view.addSubview(view)
        self.didMove(toParent: viewController)

    }
    
    public func stopSpinner(){
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
