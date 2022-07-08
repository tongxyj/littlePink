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
        view.backgroundColor = .red
        segmentTitleView.segmentTitles = chaneels
        segmentTitleView.sliderHeight = 3
        segmentTitleView.isShowSlider = false
        view.addSubview(segmentTitleView)
        segmentTitleView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        //containerview
//        view.addSubview(containerView)
//        containerView.contentView = view
//        containerView.collectionViewitemsCount = Chaneels.count
//        containerView.snp.makeConstraints { make in
//            make.top.equalTo(segmentTitleView.snp.bottom)
//            make.left.right.equalTo(view)
//            make.bottom.equalTo(-kTabBarHeight)
//        }
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
