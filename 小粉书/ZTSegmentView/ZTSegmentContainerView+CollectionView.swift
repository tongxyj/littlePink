//
//  ZTSegmentContainer+CollectionView.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/8.
//

import UIKit

extension ZTSegmentContainerView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewitemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kZTSegmentContainerCellId, for: indexPath) as! ZTSegmentContainerCell
    
        if contentViews.count > 0 && indexPath.item < contentViews.count {
            let contentView = contentViews[indexPath.item]
            cell.displayView = contentView
        }
       
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: CGFloat(insetHorMargein), bottom: 0, right: CGFloat(insetHorMargein))
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        kMinimumLineSpacing
//    }
}
