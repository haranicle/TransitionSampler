//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PhotoCollection

let vc = UIStoryboard(name: "PhotoCollection", bundle: nil).instantiateInitialViewController()
XCPlaygroundPage.currentPage.liveView = vc

extension PhotoCollectionNavigationController {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .Push:
            fromVC
            return nil
        case .Pop:
            return nil
        case .None:
            return nil
        }
    }
}

class ExpandingTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var fromImageView: UIImageView
    var fromPoint:CGPoint
    var toRect: CGRect
    
    init(fromImageView: UIImageView, fromPoint:CGPoint , toRect: CGRect) {
        self.fromImageView = fromImageView
        self.fromPoint = fromPoint
        self.toRect = toRect
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            containerView = transitionContext.containerView()
            else {
                return
        }
        
        let expandingImageView = UIImageView(image: fromImageView.image)
        expandingImageView.contentMode = fromImageView.contentMode
        expandingImageView.clipsToBounds = true
        expandingImageView.frame.origin = fromPoint
        expandingImageView.frame.size = fromImageView.frame.size
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(expandingImageView)
        toVC.view.alpha = 0
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 10,
            options: .CurveEaseOut,
            animations: { () -> Void in
                toVC.view.alpha = 1
                expandingImageView.frame = self.toRect
        }) { _ in
            expandingImageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}

class ContractingTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var fromImageView: UIImageView
    var fromPoint: CGPoint
    var toRect: CGRect
    
    init(fromImageView: UIImageView, fromPoint:CGPoint , toRect: CGRect) {
        self.fromImageView = fromImageView
        self.fromPoint = fromPoint
        self.toRect = toRect
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            containerView = transitionContext.containerView()
            else {
                return
        }
        
        let contractingImageView = UIImageView(image: fromImageView.image)
        contractingImageView.contentMode = fromImageView.contentMode
        contractingImageView.clipsToBounds = true
        contractingImageView.frame.origin = fromPoint
        contractingImageView.frame.size = fromImageView.frame.size
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(contractingImageView)
        toVC.view.alpha = 0
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            delay: 0,
            options: .CurveEaseInOut,
            animations: { _ in
                toVC.view.alpha = 1
                contractingImageView.alpha = 0
                contractingImageView.frame = self.toRect
        }) { _  in
            contractingImageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
