//
//  SwipingController.swift
//  intro_app
//
//  Created by Sailung Yeung on 2/16/19.
//  Copyright © 2019 xyy. All rights reserved.
//

import UIKit

struct Page {
    
    let imageName: String
    let headerText: String
    let bodyText: String
    
}

extension UIColor{
    static var mainGreen = UIColor.black
}

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
        
        coordinator.animate(alongsideTransition: {(_) in
            self.collectionViewLayout.invalidateLayout()
            
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }){(_) in}
    }
    
    
    
    let pages = [
        Page(imageName: "Swipe1", headerText: "Expressing helps", bodyText: "Feel bad? Talk to someone."),
        Page(imageName: "Swipe2", headerText: "Share stories ", bodyText: "Tell your stories to people who have similar experiences"),
        Page(imageName: "Swipe3", headerText: "Stay anonymously", bodyText:"Only the name you chose will be displayed to others"),
        Page(imageName: "Swipe4", headerText: "Understand yourself", bodyText:"Track your feelings and discover the cause")
    ]
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(handleReg), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleReg(){
        
        
//        let nameController = UINavigationController(rootViewController: NameController())
//        self.present(nameController, animated: true, completion: nil)
        let vc = buttonView()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleLogin(){
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }
    
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainGreen
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    private func setupBottomControls(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [registerButton, pageControl, loginButton])
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x/view.frame.width)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupBottomControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
//        cell.iconImageView.image = UIImage(named: page.imageName)
//        cell.descriptionTextView.text = page.headerText
        
//        let imageName = imageNames[indexPath.item]
//        cell.iconImageView.image = UIImage(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
