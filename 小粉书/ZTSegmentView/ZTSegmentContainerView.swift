//
//  ZTSegmentContainerView.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/8.
//

import UIKit
import SnapKit

class ZTSegmentContainerView: UIView {
    
    var collectionViewitemsCount = 0 {
        willSet{
//            containerCollectionView.reloadData()
        }
    }
    var contentViews: [UIView] = [] {
        willSet {
            
        }
    }
    
    lazy var containerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        }
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.register(ZTSegmentContainerCell.self, forCellWithReuseIdentifier: kZTSegmentContainerCellId)
        return collectionView
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerCollectionView)
        
        containerCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
