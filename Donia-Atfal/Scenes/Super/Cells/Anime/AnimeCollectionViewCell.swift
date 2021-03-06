//
//  AnimeCollectionViewCell.swift
//  Cool Kids
//
//  Created by lodex solutions on 3/17/20.
//  Copyright © 2020 ioslam. All rights reserved.
//

import UIKit

class AnimeCollectionViewCell : UICollectionViewCell{
    
    @IBOutlet var contentCollectionView: UICollectionView!
    @IBOutlet weak var category_label: UILabel!
    
    let cell_ID = "contentCell"
       var categories = [Category]() {
        didSet {
            self.contentCollectionView.reloadData()
        }
    }
    var selectedIndexPath: IndexPath!
    var selected_anime : ((Category)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cell_ID)
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.semanticContentAttribute = .forceRightToLeft
    }
}

extension AnimeCollectionViewCell: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_ID, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        cell.iv.layer.cornerRadius = 12
        Helper.displayImage(imageView: cell.iv , url: categories[indexPath.row].image!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected_anime?(categories[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 190)
    }
    
    
}
extension AnimeCollectionViewCell: ZoomingViewController {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        if let indexPath = selectedIndexPath {
            let cell = contentCollectionView.cellForItem(at: indexPath) as! ContentCollectionViewCell
                return cell.iv
        } else {
            return nil
        }
}
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        
        return nil
    }
}
