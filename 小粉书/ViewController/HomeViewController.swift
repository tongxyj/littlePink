//
//  HomeViewController.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/6.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    lazy var segmentTitleView: HomeSegmentView = {
        HomeSegmentView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titles = ["发现", "关注", "附近"]
        segmentTitleView.segmentTitles = titles
        segmentTitleView.divideLineHeight = 3
        view.addSubview(segmentTitleView)
        segmentTitleView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        // Do any additional setup after loading the view.
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
