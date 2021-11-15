//
//  ViewController.swift
//  CatsApp
//
//  Created by Darek on 12/11/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var catsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat(10)
        let collectonView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectonView.backgroundColor = .appLightBlue
        collectonView.automaticallyAdjustsScrollIndicatorInsets = false
        collectonView.showsVerticalScrollIndicator = false
        collectonView.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: "catCollectionViewCell")

        return collectonView
    }()
    private var catsHanlder: CatsHandler?
    private var cats: [Cat] = [] {
        didSet{
            DispatchQueue.main.async {
                self.catsCollectionView.reloadData()
            }
            print("Reload data")
        }
    }
    private var timer: Timer?
    private let refreshTime: Double = 20.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        catsHanlder = CatsHandler(apiService: CatsApi(), jsonDecoder: CatsJsonDecoder())
        // Do any additional setup after loading the view.
        self.title = "Cats"
        
        catsCollectionView.delegate = self
        catsCollectionView.dataSource = self
        configureCatsColecionView()
        handleCats()
        timer = Timer.scheduledTimer(timeInterval: refreshTime, target: self, selector: #selector(handleCats), userInfo: nil, repeats: true)
    }
    
    //MARK: - Helper functions
    func configureCatsColecionView(){
        view.addSubview(catsCollectionView)
        catsCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    @objc func handleCats(){
        catsHanlder?.handle(completion: {[unowned self] newCats in
            guard let newCats = newCats else {
               return
            }
            self.cats = newCats
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: catsCollectionView.bounds.width/2 - 15, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = catsCollectionView.dequeueReusableCell(withReuseIdentifier: "catCollectionViewCell", for: indexPath) as! CatCollectionViewCell
        cell.cat = cats[indexPath.row]
        
        return cell
    }
    
    
}

