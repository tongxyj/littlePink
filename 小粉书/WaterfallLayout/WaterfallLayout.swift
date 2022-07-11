//
//  WaterfallLayout.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/9.
//

import UIKit
@objc protocol WaterfallLayoutDelegate {
    
    func waterfallLayoutColumns() -> Int
    func waterfallLayout(_ waterfallLayout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

class WaterfallLayout: UICollectionViewFlowLayout {
    weak var delegate: WaterfallLayoutDelegate?
    // 布局数组
    lazy var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    // 高度数组
    lazy var itemYIndexes: [CGFloat] = []
    
    var maxHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        var cols = 0
        
        if delegate != nil {
            cols = delegate!.waterfallLayoutColumns()
            itemYIndexes = Array(repeating: self.sectionInset.top, count: cols)
        }
        // 计算每个 Cell 的宽度
        let itemWidth = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        // Cell 数量
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        // 最小高度索引
        var minHeightIndex = 0
        // 遍历 item 计算并缓存属性
        for i in layoutAttributes.count ..< itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 获取动态高度
            var itemHeight: CGFloat = 0
            if delegate != nil {
                let itemSize = delegate!.waterfallLayout(self, sizeForItemAt: indexPath)
                
                itemHeight = itemSize.height * itemWidth / itemSize.width
            }
            // 找到高度最短的那一列
            if let value = itemYIndexes.min() {
                // 获取数组索引
                minHeightIndex = itemYIndexes.firstIndex(of: value)!
            }
            // 获取该列的 Y 坐标
            var itemY = itemYIndexes[minHeightIndex]
            // 判断是否是第一行，如果换行需要加上行间距
            if i >= cols {
                itemY += minimumInteritemSpacing
            }
            
            // 计算该索引的 X 坐标
            let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            // 赋值新的位置信息
            attr.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
            // 缓存布局属性
            layoutAttributes.append(attr)
            // 更新最短高度列的数据
            itemYIndexes[minHeightIndex] = attr.frame.maxY
        }
        maxHeight = itemYIndexes.max()! + sectionInset.bottom
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 返回相交的区域
        return layoutAttributes.filter {
            $0.frame.intersects(rect)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width, height: maxHeight)
    }
}
