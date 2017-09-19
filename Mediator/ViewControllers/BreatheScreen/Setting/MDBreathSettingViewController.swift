//
//  MDBreathSettingViewController.swift
//  Mediator
//
//  Created by VuVince on 9/18/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDBreathSettingViewController: MDBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    let viewModel = MDBreathSettingViewModel()
    var dataSource: MDCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCollectionView()
        setupPageControl()
    }
    
    func bindCollectionView() {
        dataSource = MDCollectionViewDataSource(collectionView: collectionView, owner: self, dataProvider: viewModel.dataProvider)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = viewModel.dataProvider.numberOfItems(in: 0)
        pageControl.currentPage = 0
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didCickCloseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MDBreathSettingViewController: MDCollectionViewDataSourceProtocol {
    func collectionView(_ collectionView: UICollectionView, itemSizeAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, dequeueReusableCellAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl()
    }
    
    func updatePageControl() {
        var midOffset = collectionView.contentOffset
        midOffset.x += view.frame.width / 2.0
        midOffset.y = collectionView.frame.height / 2.0
        if let indexPath = collectionView.indexPathForItem(at: midOffset) {
            pageControl.currentPage = indexPath.row
        }
    }
    
}
