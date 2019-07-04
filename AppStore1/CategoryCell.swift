//
//  CategoryCell.swift
//  AppStore1
//
//  Created by Macbook Pro on 08/05/2018.
//  Copyright © 2018 iotech. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 
    
    var appCategory: AppCategory? {
        
        didSet{
            if let name = appCategory?.name {
                nameLabel.text = name
            }
        }
    }
    
    let cellID = "AppCellId"
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let appCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupView(){
        backgroundColor = UIColor.clear
        
        addSubview(nameLabel)
        addSubview(appCollectionView)
        addSubview(dividerLineView)
        
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        appCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellID)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":dividerLineView]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":appCollectionView]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":appCollectionView,"v1":dividerLineView,"nameLabel":nameLabel]))

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: frame.height-32)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 14, left: 14, bottom: 0, right: 14)
    }
}

class AppCell: UICollectionViewCell {
    
    var app: App?{
        didSet{
            if let name = app?.Name {
                nameLabel.text = app?.Name
                
                let rect = NSString(string: name).boundingRect(with: CGSize(width: frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if rect.height > 20 {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
                } else {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 22, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width + 40, width: frame.width, height: 20)
                }
                
                nameLabel.frame = CGRect(x: 0, y: frame.width + 5, width: frame.width, height: 40)
                nameLabel.sizeToFit()
                
            }
            categoryLabel.text = app?.Category
            if let price = app?.Price{
                priceLabel.text = "$\(price)"
            }else{
                priceLabel.text = ""
            }
            if let imageName = app?.ImageName{
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView2()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage(named: "azadi")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
//        label.text = "USG build  Azadi"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
        
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    
    func setupView2(){
//        backgroundColor = UIColor.black

        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)

        imageView.frame = CGRect(x:0, y:0, width:frame.width,height:frame.width)
        nameLabel.frame = CGRect(x:0, y:frame.width+2, width:frame.width,height: 40)
        categoryLabel.frame = CGRect(x:0, y:frame.width+38, width:frame.width,height: 20 )
        priceLabel.frame = CGRect(x:0, y:frame.width+56, width:frame.width,height: 20 )

    }
}
