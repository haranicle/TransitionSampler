//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PhotoCollection
import AVFoundation

let vc = UIStoryboard(name: "PhotoCollection", bundle: nil).instantiateInitialViewController()
XCPlaygroundPage.currentPage.liveView = vc

extension PhotoCollectionViewController {
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        guard let fromVC = source as? PhotoCollectionViewController,
            fromCollectionView = fromVC.collectionView,
            fromSelectedIndexPath = fromCollectionView.indexPathsForSelectedItems()?.first,
            fromCell = fromCollectionView.cellForItemAtIndexPath(fromSelectedIndexPath) as? PhotoCollectionViewCell else {
                return nil
        }
        
        let fromPoint = CGPoint(
            x: fromCell.frame.origin.x,
            y: fromCell.frame.origin.y - fromCollectionView.contentOffset.y
        )
        let toRect = AVMakeRectWithAspectRatioInsideRect(fromCell.imageView.image!.size, fromVC.view.frame)
        
        return ExpandingTransition(fromImageView: fromCell.imageView, fromPoint: fromPoint, toRect: toRect)
        
    }

}

extension PhotoDetailViewController {
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
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
        return 10
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
