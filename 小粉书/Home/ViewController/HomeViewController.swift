//
//  HomeViewController.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/6.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    lazy var segmentTitleView: ZTSegmentTitleView = {
        ZTSegmentTitleView()
    }()
    
    lazy var containerView: ZTSegmentContainerView = {
        ZTSegmentContainerView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //顶部tab
        let titles = ["发现", "关注", "附近"]
        segmentTitleView.segmentTitles = titles
        segmentTitleView.sliderHeight = 3
        segmentTitleView.delegate = self
        
        view.addSubview(segmentTitleView)
        segmentTitleView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        //containerview
        containerView.collectionViewitemsCount = titles.count
        let discoveryVC = DiscoveryViewController()
        self.addChild(discoveryVC)
        discoveryVC.didMove(toParent: self)
        
        let followVC = FollowViewController()
        self.addChild(followVC)
        followVC.didMove(toParent: self)
        
        let nearbyVC = NearbyViewController()
        self.addChild(nearbyVC)
        nearbyVC.didMove(toParent: self)
        
        containerView.contentViews = [discoveryVC.view, followVC.view, nearbyVC.view]
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(segmentTitleView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(-kTabBarHeight)
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
