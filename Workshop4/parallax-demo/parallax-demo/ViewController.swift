//
//  ViewController.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var parentParallaxingView: UIScrollView!
    @IBOutlet weak var childParallaxingView: UIView! {
        didSet {
            // Ensure that childParallaxingView is behind spacer views
            childParallaxingView.layer.zPosition = -1
        }
    }
    @IBOutlet var spacerViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let initialScrollRect = CGRect(x: 0, y: parentParallaxingView.contentSize.height * 0.25,
                                       width: 1,
                                       height: parentParallaxingView.frame.size.height)
        parentParallaxingView.scrollRectToVisible(initialScrollRect, animated: false)
    }
    
    @IBAction func showHiddenValuesToggled(_ sender: Any) {
        guard let hiddenValuesSwitch = sender as? UISwitch else {
            return
        }
        
        for view in spacerViews {
            view.alpha = hiddenValuesSwitch.isOn ? 0.6 : 1.0
        }
    }
}

