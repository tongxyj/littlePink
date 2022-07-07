//
//  HomeSegmentView.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/6.
//

import UIKit
import SnapKit
import CoreGraphics

let kMinimumLineSpacing: CGFloat = 20

class HomeSegmentView: UIView {
    ///当前选中索引
    var currentSelIndex = 0
    var insetHorMargein: CGFloat = 0
    var divideLineHeight: CGFloat = 0 {
        willSet {
            divideLine.snp.remakeConstraints { make in
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
                let labelWidth = label.intrinsicContentSize.width + kMinimumLineSpacing
                tempWidths.append(labelWidth)
                totalTitleWidth += labelWidth
            }
            insetHorMargein = (kScreenWidth - (totalTitleWidth + CGFloat(segmentTitles.count - 1) * kMinimumLineSpacing)) / 2
            segmentTitleWidths = tempWidths
        }
    }
    ///下划线
    lazy var divideLine: UIView = {
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
        collectionView.register(SegmentCell.self, forCellWithReuseIdentifier: kMainSegmentCellId)
        return collectionView
    }()
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(segmentContainerCollectionView)
        addSubview(divideLine)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        segmentContainerCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        guard currentSelIndex < segmentTitleWidths.count else {
            return
        }
        let lineWidth = segmentTitleWidths[currentSelIndex]
        let lineLeft = insetHorMargein + CGFloat(currentSelIndex) * lineWidth
        divideLine.frame = CGRect(x: lineLeft, y: segmentContainerCollectionView.frame.maxY - divideLineHeight, width: lineWidth, height: divideLineHeight)
//        divideLine.snp.makeConstraints { make in
//            make.left.equalTo(self).offset(lineLeft)
//            make.bottom.equalTo(self)
//            make.width.equalTo(lineWidth)
//        }
    }
    
}
// MARK: - UICollectionViewDelegate
extension HomeSegmentView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        segmentTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMainSegmentCellId, for: indexPath) as! SegmentCell
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
        let lineWidth = segmentTitleWidths[currentSelIndex]
        let lineLeft = insetHorMargein + CGFloat(currentSelIndex) * lineWidth + CGFloat(currentSelIndex) * kMinimumLineSpacing
//        divideLine.snp.updateConstraints { make in
//            make.width.equalTo(lineWidth)
//            make.left.equalTo(self).offset(lineLeft)
//        }
      
        CATransaction.setDisableActions(false)
        collectionView.reloadData()
        CATransaction.commit();
        UIView.animate(withDuration: 0.5, animations: {
            self.divideLine.frame = CGRect(x: lineLeft, y: self.segmentContainerCollectionView.frame.maxY - self.divideLineHeight, width: lineWidth, height: self.divideLineHeight)
            self.layoutIfNeeded()
        })
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.item < segmentTitleWidths.count else {
            return CGSize.zero
        }
        let titleWidth = segmentTitleWidths[indexPath.item]
        
        return CGSize(width: titleWidth, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: CGFloat(insetHorMargein), bottom: 0, right: CGFloat(insetHorMargein))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        kMinimumLineSpacing
    }
}
