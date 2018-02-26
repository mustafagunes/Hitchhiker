//
//  ContainerVC.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 26.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit
import QuartzCore

enum SliderOutState {
    
    case collapsed
    case leftPanelExpanded
}

enum ShowWhichVC {
    
    case homeVC
}

var showVC : ShowWhichVC = .homeVC

class ContainerVC: UIViewController {

    var homeVC : HomeVC!
    var leftVC : LeftSidePanelVC!
    var centerController : UIViewController!
    var currentState : SliderOutState = .collapsed {
        didSet{
            
            let shouldShowShadow = (currentState != .collapsed)
            
            shouldShowShadowForCenterViewController(status: shouldShowShadow)
        }
    }
    
    var isHidden = false
    let centerPanelExpandedOffset : CGFloat = 160
    
    var tap : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCenter(screen: showVC)
    }
    
    func initCenter(screen : ShowWhichVC) {
        
        var presentingController : UIViewController
        
        showVC = screen
        
        if homeVC == nil
        {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        
        presentingController = homeVC
        
        if let con = centerController
        {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }

    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
}

extension ContainerVC : CenterVCDelegate {
    
    func toggleLeftPanel() {
        
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded
        {
            addLeftPanelViewController()
        }
        animateLefttPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        
        if leftVC == nil
        {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC!)
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC) {
        
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func animateLefttPanel(shouldExpand: Bool) {
        
        if shouldExpand
        {
            isHidden = !isHidden
            animateStatusBar()
            
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
        }
        else
        {
            isHidden = !isHidden
            animateStatusBar()
            
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                
                if finished == true
                {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
        }
    }
    
    func animateCenterPanelXPosition(targetPosition : CGFloat, completion : ((Bool) -> Void)! = nil) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            self.centerController.view.frame.origin.x = targetPosition
            
        }, completion: completion)
    }
    
    func setupWhiteCoverView() {
        
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        
        UIView.animate(withDuration: 0.2) {
            
            whiteCoverView.alpha = 0.75
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLefttPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCoverView() {
        
        centerController.view.removeGestureRecognizer(tap)
        
        for subview in self.centerController.view.subviews
        {
            if subview.tag == 25
            {
                UIView.animate(withDuration: 0.2, animations: {
                    
                    subview.alpha = 0.0
                    
                }, completion: { (finished) in
                    
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    func shouldShowShadowForCenterViewController(status : Bool) {
        
        if status == true
        {
            centerController.view.layer.shadowOpacity = 0.6
        }
        else
        {
            centerController.view.layer.shadowOpacity = 0.6
        }
    }
    
    func animateStatusBar() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}

private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSidePanelVC? {
        
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    
    class func homeVC() -> HomeVC? {
        
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}
