//
//  HomeViewController+ZTSegmentTitleView.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/8.
//

import UIKit

extension HomeViewController: ZTSegmentTitleViewDelegate {
    func segmentTitleView(didSelectSegmentAt index: Int) {
        containerView.containerCollectionView.setContentOffset(CGPoint(x: CGFloat(index) * kScreenWidth, y: 0), animated: true)
    }
}
