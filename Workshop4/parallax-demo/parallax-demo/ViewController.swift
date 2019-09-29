//
//  ViewController.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var parallaxingBackgroundView: BackgroundView! {
        didSet {
            parallaxingBackgroundView.delegate = self
            parallaxingBackgroundView.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var parallaxingForegroundView: ForegroundView! {
        didSet {
            // Ensure that foregroundParallaxingView is behind spacer views
            parallaxingForegroundView.layer.zPosition = -1
        }
    }
    @IBOutlet weak var diagnostic: UILabel!
    @IBOutlet var spacerViews: [UIView]!
    @IBOutlet var diagnosticLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let initialScrollRect = CGRect(x: 0, y: parallaxingBackgroundView.contentSize.height * 0.25,
                                       width: 1,
                                       height: parallaxingBackgroundView.frame.size.height)
        parallaxingBackgroundView.scrollRectToVisible(initialScrollRect, animated: false)
    }
    
    @IBAction func pauseParallaxToggled(_ sender: Any) {
        guard let parallaxSwitch = sender as? UISwitch else {
            return
        }
        
        parallaxingForegroundView.pauseParallax = parallaxSwitch.isOn
    }
    
    @IBAction func parallaxEffectStrength(_ sender: Any) {
        guard let strengthSlider = sender as? UISlider else {
            return
        }
        
        parallaxingForegroundView.parallaxStrength = CGFloat(strengthSlider.value)
        scrollViewDidScroll(parallaxingBackgroundView)
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

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        parallaxingBackgroundView.updateParallax(for: parallaxingForegroundView)
        updateDiagnostics()
    }

    func updateDiagnostics() {
        let offsetText = String(format: "offset = %0.1f", parallaxingBackgroundView.contentOffset.y)
        diagnostic.text = """
                          background:
                          \(offsetText)
                          """
    }
}
