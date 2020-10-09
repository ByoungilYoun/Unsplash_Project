//
//  PhotoCollectionViewController.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/10.
//

import UIKit

class PhotoCollectionViewController : UIViewController {
   
  //MARK: - Properties
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavi()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(moveBack))
  }
  
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
}
