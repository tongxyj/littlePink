//
//  ZTSegmentContainerCell.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/8.
//

import UIKit
import SnapKit

class ZTSegmentContainerCell: UICollectionViewCell {

    var displayView: UIView! {
        willSet {
            contentView.addSubview(newValue)
            newValue.snp.makeConstraints { make in
                make.edges.equalTo(contentView)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
