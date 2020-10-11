//
//  PhotoCollectionViewController.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/10.
//

import UIKit

class PhotoCollectionViewController : UIViewController {
   
  //MARK: - Properties
  var photoTitle : String = "" {
    didSet {
      self.title = photoTitle + "🧑🏼‍💻"
    }
  }
  
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
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(moveBack))
  }
  
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
}
