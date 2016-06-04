//
//  PhotoCollectionViewController.swift
//  TransitionSampler
//
//  Created by kazushi.hara on 2016/06/04.
//  Copyright © 2016年 haranicle. All rights reserved.
//

import Foundation
import UIKit

public class PhotoCollectionViewController: UICollectionViewController {
    
    private var cellSize: CGSize {
        get {
            let numberOfColumns: CGFloat = 3
            let cellMargin:CGFloat = 2
            if let collectionView = collectionView {
                let cellWidth = (collectionView.frame.width - cellMargin * (numberOfColumns - 1)) / numberOfColumns
                return CGSize(width: cellWidth, height: cellWidth)
            }
            return CGSize.zero
        }
    }
    
    private func photo(atIndex index: Int) -> UIImage {
        return UIImage(named: "photos/\(index + 1).JPG")!
    }
    
    // MARK: - UICollectionViewDataSource
    
    override public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    // MARK: - UICollectionViewDelegate
    
    override public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? PhotoCollectionViewCell else {
            fatalError("failed to dequeueReusableCellWithIdentifier(\"PhotoCollectionViewCell\")")
        }
        cell.imageView.image = photo(atIndex: indexPath.item)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return cellSize
    }
    
    // MARK: - Storyboard
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let selectedIndexPath = collectionView?.indexPathsForSelectedItems()?.first else {
            return
        }
        
        switch segue.identifier {
        case "PushPhotoDetail"?:
            guard let photoDetailViewController = segue.destinationViewController as? PhotoDetailViewController else {
                return
            }
            photoDetailViewController.image = photo(atIndex: selectedIndexPath.item)
            return
        default:
            return
        }
    }
    
}