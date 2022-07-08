//
//  HomeSegmentView.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/6.
//

import UIKit
import SnapKit
import CoreGraphics

@objc protocol ZTSegmentTitleViewDelegate {
    func segmentTitleView(didSelectSegmentAt index: Int)
}


class ZTSegmentTitleView: UIView {
    weak var delegate: ZTSegmentTitleViewDelegate?
    
    ///当前选中索引
    var currentSelIndex = 0
    var isShowSlider = true {
        willSet {
            slider.isHidden = !newValue
        }
    }
    var insetHorizontalMargin: CGFloat = 0
    var sliderHeight: CGFloat = 0 {
        willSet {
            slider.snp.updateConstraints { make in
                make.height.equalTo(newValue)
            }
        }
    }
    ///每个标题的宽度数组
    var segmentTitleWidths: [CGFloat] = []
    ///标题数组
    var segmentTitles = [String]() {
        didSet {
            var totalTitleWidth: CGFloat = 0
            var tempWidths: [CGFloat] = []
            for title in segmentTitles {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.font = KFont16
                label.text = title
                let labelWidth = label.intrinsicContentSize.width + kSegmentTitleMinimumLineSpacing
                tempWidths.append(labelWidth)
                totalTitleWidth += labelWidth
            }
            insetHorizontalMargin = (kScreenWidth - (totalTitleWidth + CGFloat(segmentTitles.count - 1) * kSegmentTitleMinimumLineSpacing)) / 2
            if insetHorizontalMargin < 0 {
                insetHorizontalMargin = kSegmentTitleHorizontalInsetMargin
            }
            segmentTitleWidths = tempWidths
            
            let lineWidth = segmentTitleWidths[currentSelIndex]
            let lineLeft = insetHorizontalMargin + CGFloat(currentSelIndex) * lineWidth
            slider.snp.updateConstraints { make in
                make.left.equalTo(self).offset(lineLeft)
                make.bottom.equalTo(self)
                make.width.equalTo(lineWidth)
            }
        }
    }
    ///下划线
    lazy var slider: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(named: kMainColor)
        return lineView
    }()
    
    lazy var segmentContainerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        }
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.register(ZTSegmentTitleCell.self, forCellWithReuseIdentifier: kZTSegmentTitleCellId)
        return collectionView
    }()
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(segmentContainerCollectionView)
        segmentContainerCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        if isShowSlider {
            addSubview(slider)
            slider.snp.makeConstraints { make in
                make.left.equalTo(self)
                make.bottom.equalTo(self)
                make.width.equalTo(1)
                make.height.equalTo(1)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

