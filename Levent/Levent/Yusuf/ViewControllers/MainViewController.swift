//
//  ViewController.swift
//  Levent
//
//  Created by k 3 on 04/12/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var mainHeaderView: UIView!
    
    lazy var slidesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        let cardNib = UINib(nibName: CardCollectionViewCell.identifier, bundle: nil)
        collectionView.register(cardNib, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    var numberOfItems = 5
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Homepage"
        
        topHeaderView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        topHeaderView.layer.shadowOffset = CGSize(width: 0, height: -2)
        topHeaderView.layer.shadowRadius = 4
        topHeaderView.layer.masksToBounds = false
        statsView.layer.cornerRadius = 10
        statsView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        statsView.layer.borderWidth = 0.5
        
        
        statsView.layer.shadowColor = UIColor.black.cgColor
        statsView.layer.shadowOpacity = 0.2
        statsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        statsView.layer.shadowRadius = 2
        
        pageControl.numberOfPages = numberOfItems
        
        mainHeaderView.addSubview(slidesCollectionView)
        
        NSLayoutConstraint.activate([
            slidesCollectionView.topAnchor.constraint(equalTo: mainHeaderView.topAnchor),
            slidesCollectionView.leadingAnchor.constraint(equalTo: mainHeaderView.leadingAnchor),
            slidesCollectionView.trailingAnchor.constraint(equalTo: mainHeaderView.trailingAnchor),
            slidesCollectionView.bottomAnchor.constraint(equalTo: mainHeaderView.bottomAnchor)
       ])
        
        
    }


}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = page
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventDetailSegue", sender: nil)
    }
    
}

