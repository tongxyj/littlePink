//
//  SegmentCell+CollectionView.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/8.
//

import UIKit

extension ZTSegmentTitleView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        segmentTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kZTSegmentTitleCellId, for: indexPath) as! ZTSegmentTitleCell
        guard indexPath.item < segmentTitles.count else {
            return cell
        }
        let titleStr = segmentTitles[indexPath.item]
        cell.titleLabel.text = titleStr
        cell.titleLabel.textColor = (indexPath.item == currentSelIndex) ? .label : .secondaryLabel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelIndex = indexPath.item
       
        if delegate != nil {
           delegate!.segmentTitleView(didSelectSegmentAt: currentSelIndex)
        }
        
        CATransaction.setDisableActions(false)
        collectionView.reloadData()
        CATransaction.commit();
        
        if isShowSlider {//滑动条动画
            let lineWidth = segmentTitleWidths[currentSelIndex]
            let lineLeft = insetHorizontalMargin + CGFloat(currentSelIndex) * lineWidth + CGFloat(currentSelIndex) * kSegmentTitleMinimumLineSpacing
        
            UIView.animate(withDuration: 0.5, animations: {
                self.slider.snp.updateConstraints { make in
                    make.width.equalTo(lineWidth)
                    make.left.equalTo(self).offset(lineLeft)
                }
                self.layoutIfNeeded()
            })
        }
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.item < segmentTitleWidths.count else {
            return CGSize.zero
        }
        let titleWidth = segmentTitleWidths[indexPath.item]
        
        return CGSize(width: titleWidth, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: CGFloat(insetHorizontalMargin), bottom: 0, right: CGFloat(insetHorizontalMargin))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        kSegmentTitleMinimumLineSpacing
    }
}
