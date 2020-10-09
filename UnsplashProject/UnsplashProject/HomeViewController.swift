//
//  HomeViewController.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/10.
//

import UIKit

class HomeViewController : UIViewController {
  
  //MARK: - Properties
  private let iconImage : UIImageView = {
    let im = UIImageView()
    im.image = UIImage(named: "unsplash")
    return im
  }()
  
  private let searchFilterSegment : UISegmentedControl = {
    let sg = UISegmentedControl()
    sg.insertSegment(with: UIImage(systemName:"photo"), at: 0, animated: true)
    sg.insertSegment(with: UIImage(systemName: "person.fill"), at: 1, animated: true)
    sg.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
    sg.selectedSegmentTintColor = .white
    sg.accessibilityScroll(.right)
    sg.addTarget(self, action: #selector(searchFilterValueChanged), for: .valueChanged)
    return sg
  }()
  
  private let searchBar : UISearchBar = {
    let sb = UISearchBar()
    sb.searchBarStyle = .minimal // searchBar 위, 아래 줄 사라지게 하기
    return sb
  }()
  
  private let searchButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("검색", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = .systemPink
    bt.layer.cornerRadius = 10
    bt.addTarget(self, action: #selector(onSearchButtonClicked), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavi()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - configureUI()
  private func configureUI() {
    view.backgroundColor = .systemBackground
    
    [iconImage, searchFilterSegment, searchBar, searchButton].forEach {
      view.addSubview($0)
    }
    
    let height = view.frame.size.height
    
    iconImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(height / 15)
      $0.width.height.equalTo(150)
    }
    
    searchFilterSegment.snp.makeConstraints {
      $0.top.equalTo(iconImage.snp.bottom).offset(15)
      $0.leading.equalTo(iconImage.snp.leading)
      $0.trailing.equalTo(iconImage.snp.trailing)
    }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(searchFilterSegment.snp.bottom).offset(18)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(10)
    }
  
    searchButton.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(20)
      $0.leading.equalTo(iconImage.snp.leading).offset(20)
      $0.trailing.equalTo(iconImage.snp.trailing).offset(-20)
    }
  }
  
  //MARK: - @objc func
  @objc func searchFilterValueChanged(_ sender : UISegmentedControl) {
    var searchBarTitle = ""
    
    switch sender.selectedSegmentIndex {
    case 0 :
      searchBarTitle = "사진 키워드"
    default :
      searchBarTitle = "사용자 이름"
    }
    
    self.searchBar.placeholder = searchBarTitle + "입력"
    self.searchBar.becomeFirstResponder()
  }
  
  @objc func onSearchButtonClicked(_ sender : UIButton) {
    switch searchFilterSegment.selectedSegmentIndex {
    case 0 :
      let controller = PhotoCollectionViewController()
      controller.modalPresentationStyle = .fullScreen
      navigationController?.pushViewController(controller, animated: true)
    default :
      let controller = UserListViewController()
      controller.modalPresentationStyle = .fullScreen
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}
