//
//  ZTWaterfalCellCollectionViewCell.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/9.
//

import UIKit

class WaterfallCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.randomColor
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
