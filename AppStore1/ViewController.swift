//
//  ViewController.swift
//  AppStore1
//
//  Created by Macbook Pro on 06/05/2018.
//  Copyright © 2018 iotech. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {    
    
    private let cellID = "cellID";
    fileprivate let largeCellId = "largeCellId"
    
    var featuredApps: FeaturedApps?
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Featured Apps"
        
        AppCategory.fetchFeaturedApps{ (featuredApps) -> () in
            self.featuredApps = featuredApps
            self.appCategories = featuredApps.categories
            self.collectionView?.reloadData()
        }
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register( CategoryCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CategoryCell
        if indexPath.item == 2 {
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
        }else{
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        }
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int{
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        return CGSize(width: view.frame.width, height: 230)
    }
    
    class LargeCategoryCell: CategoryCell{
        fileprivate let largeAppCellId = "largeAppCellId"
        
        override func setupView() {
            super.setupView()
            appCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: "largeAppCellId")
            
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as! LargeAppCell
            cell.app = appCategory?.apps?[indexPath.item]
            return cell
        }
        
        override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: frame.height - 32)
        }
        
        
        
        fileprivate class LargeAppCell: AppCell{
            fileprivate override func setupView2() {
                imageView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(imageView)
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView]))
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView]))
                
            }
        }
    }
    
}

