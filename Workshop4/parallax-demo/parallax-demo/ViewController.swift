//
//  ViewController.swift
//  parallax-demo
//
//  Created by Kent Humphries on 19/9/19.
//  Copyright © 2019 HumpBot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var parallaxingParentView: ParentView! {
        didSet {
            parallaxingParentView.delegate = self
            parallaxingParentView.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var parallaxingChildView: ChildView! {
        didSet {
            // Ensure that childParallaxingView is behind spacer views
            parallaxingChildView.layer.zPosition = -1
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
        let initialScrollRect = CGRect(x: 0, y: parallaxingParentView.contentSize.height * 0.25,
                                       width: 1,
                                       height: parallaxingParentView.frame.size.height)
        parallaxingParentView.scrollRectToVisible(initialScrollRect, animated: false)
    }
    
    @IBAction func showHiddenValuesToggled(_ sender: Any) {
        guard let hiddenValuesSwitch = sender as? UISwitch else {
            return
        }
        
        for view in spacerViews {
            view.alpha = hiddenValuesSwitch.isOn ? 0.6 : 1.0
        }
    }
    
    @IBAction func showDiagnosticDataToggled(_ sender: Any) {
        guard let diagnosticDataSwitch = sender as? UISwitch else {
            return
        }

        for view in diagnosticLabels {
            view.alpha = diagnosticDataSwitch.isOn ? 1.0 : 0.0
        }
    }
    
    @IBAction func pauseParallaxToggled(_ sender: Any) {
        guard let parallaxSwitch = sender as? UISwitch else {
            return
        }
        
        parallaxingChildView.pauseParallax = parallaxSwitch.isOn
    }
    
    @IBAction func parallaxEffectStrength(_ sender: Any) {
        guard let strengthSlider = sender as? UISlider else {
            return
        }
        
        parallaxingChildView.parallaxStrength = CGFloat(strengthSlider.value)
        scrollViewDidScroll(parallaxingParentView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        parallaxingParentView.updateParallax(for: parallaxingChildView)
        updateDiagnostics()
    }

    func updateDiagnostics() {
        let normalizedText = String(format: "Normalized Parallax = %0.4f",
                                    parallaxingParentView.normalizedChildOffset(parallaxingChildView))
        let offsetText = String(format: "scrollOffset = %0.2f", parallaxingParentView.contentOffset.y)
        let relativeChildText = String(format: "relative offset of child bottom = %0.2f",
                                       parallaxingParentView.visibleOffsetOfButtom(for: parallaxingChildView))
        diagnostic.text = """
                             ParallaxingParentView
                             \(normalizedText)
                             \(offsetText)
                             \(relativeChildText)
                          """
    }
}
