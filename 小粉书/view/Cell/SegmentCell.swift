//
//  SegmentCell.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/6.
//

import UIKit
import SnapKit


class SegmentCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = KFont16
        return label
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
}
