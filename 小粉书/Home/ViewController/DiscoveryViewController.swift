//
//  DiscoveryViewController.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/8.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    lazy var segmentTitleView: ZTSegmentTitleView = {
        ZTSegmentTitleView()
    }()
    
    lazy var containerView: ZTSegmentContainerView = {
        ZTSegmentContainerView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //顶部tab
        let chaneels = ["推荐","旅行","娱乐","才艺","美妆","白富美","美食","萌宠"]
        segmentTitleView.segmentTitles = chaneels
        segmentTitleView.sliderHeight = 3
        segmentTitleView.isShowSlider = false
        view.addSubview(segmentTitleView)
        segmentTitleView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        //containerview
        containerView.collectionViewitemsCount = chaneels.count
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let images = [Int](1...10).map { num in
            "\(num)"
        }
        
        let waterfallVC = WaterfallViewController(collectionViewLayout: layout)
        waterfallVC.waterfallImages = images
        self.addChild(waterfallVC)
        waterfallVC.didMove(toParent: self)
        
        containerView.contentViews = [waterfallVC.view]
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(segmentTitleView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiscoveryViewController: WaterfallLayoutDelegate {
    func waterfallLayoutColumns() -> Int {
        2
    }
    
    func waterfallLayout(_ waterfallLayout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGFloat(arc4random_uniform(100))+20
//        let images = [Int](1...10).map { num in
//            "\(num)"
//        }
       
        UIImage(named: "\(indexPath.item + 1)")!.size
    }
    
    
}
