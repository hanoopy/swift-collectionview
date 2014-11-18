//
//  MyCollectionViewController.swift
//  CollectionViewTutorial
//
//  Created by bill on 2014/09/06.
//  Copyright (c) 2014年 bill. All rights reserved.
//

import UIKit
import Foundation

class MyCollectionViewController : UICollectionViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var carImages : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myFlowLayout: MyFlowLayout = MyFlowLayout()
        self.collectionView.setCollectionViewLayout(myFlowLayout, animated: true)
        
        var pinchRecognizer: UIGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        self.collectionView.addGestureRecognizer(pinchRecognizer)
        
        self.carImages = ["chevy_small.jpg",
        "mini_small.jpg",
        "rover_small.jpg",
        "smart_small.jpg",
        "highlander_small.jpg",
        "venza_small.jpg",
        "volvo_small.jpg",
        "vw_small.jpg",
        "ford_small.jpg",
        "nissan_small.jpg",
        "honda_small.jpg",
        "jeep_small.jpg"]
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer) {
        var layout: MyFlowLayout = self.collectionView.collectionViewLayout as MyFlowLayout
        if (sender.state == UIGestureRecognizerState.Began) {
            var initialPinchPoint: CGPoint = sender.locationInView(self.collectionView)
            var pinchedCellPath: NSIndexPath? = self.collectionView.indexPathForItemAtPoint(initialPinchPoint)
            layout.currentCellPath = pinchedCellPath
       }
        else if (sender.state == UIGestureRecognizerState.Changed) {
            layout.setCurrentCellCenter(sender.locationInView(self.collectionView))
            layout.setCurrentCellScale(sender.scale)
        }
        else {
            self.collectionView.performBatchUpdates({
                layout.currentCellPath = nil
                layout.currentCellScale = 1.0
                }, completion: nil)
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carImages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var myCell : MyCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as MyCollectionViewCell
        var image : UIImage
        var row : Int = indexPath.row
        image = UIImage(named: self.carImages[row])!
        myCell.imageView.image = image
        return myCell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var row: Int = indexPath.row
        self.carImages.removeAtIndex(row)
        var deletions: NSArray = [indexPath]
        self.collectionView.deleteItemsAtIndexPaths(deletions)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header : MySupplementaryView? = nil
        if (kind == UICollectionElementKindSectionHeader) {
            header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "MyHeader", forIndexPath: indexPath)
             as? MySupplementaryView
            header?.headerLabel.text = "Car Image Gallery"
        }
        return header!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var row : Int = indexPath.row
        var image : UIImage = UIImage(named: self.carImages[row])!
        return image.size
    }
    
}