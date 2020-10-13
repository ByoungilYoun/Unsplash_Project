//
//  HomeViewController.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/10.
//

import UIKit
import Toast_Swift
import Alamofire

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
    bt.isHidden = true
    return bt
  }()
  
  var keyboardDismissTapGesture = UITapGestureRecognizer(target: self, action: nil)
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavi()
    
    // 키보드 올라가는 이벤트를 받는 처리
    // 키보드 notification 등록
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notificatino:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // 키보드 notification 해제
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - configureUI()
  private func configureUI() {
    view.backgroundColor = .systemBackground
    searchBar.delegate = self
    searchBar.becomeFirstResponder() // 포커싱 주기
    keyboardDismissTapGesture.delegate = self
    view.addGestureRecognizer(keyboardDismissTapGesture)
    
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
      $0.trailing.equalToSuperview().offset(-10)
    }
  
    searchButton.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(20)
      $0.leading.equalTo(iconImage.snp.leading).offset(20)
      $0.trailing.equalTo(iconImage.snp.trailing).offset(-20)
    }
  }
  
  //MARK: -  fileprivate method
  fileprivate func pushVC() {
    switch searchFilterSegment.selectedSegmentIndex {
    case 0 :
      let controller = PhotoCollectionViewController()
      controller.modalPresentationStyle = .fullScreen
      controller.photoTitle = searchBar.text!
      navigationController?.pushViewController(controller, animated: true)
    default :
      let controller = UserListViewController()
      controller.modalPresentationStyle = .fullScreen
      controller.userTitle = searchBar.text!
      navigationController?.pushViewController(controller, animated: true)
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
    // 화면으로 이동
//    let url = API.Base_URL + "search/photos"
  
    guard let userInput = self.searchBar.text else { return }
    
    // 키, 밸류 형식의 딕셔너리
//    let queryParam = [ "query" : userInput, "client_id" : API.Client_ID]
    
//    AF.request(url, method: .get, parameters: queryParam).responseJSON(completionHandler: { response in
//      debugPrint(response)
//    })
    
    var urlToCall : URLRequestConvertible?
    
    switch searchFilterSegment.selectedSegmentIndex {
    case 0:
      urlToCall = SearchRouter.searchPhotos(term: userInput)
    case 1:
      urlToCall = SearchRouter.searchUsers(term: userInput)
    default :
      print("default")
    }
    
    if let urlConvertible = urlToCall {
      AlamofireManager.shared.session.request(urlConvertible).responseJSON(completionHandler: { response in
        debugPrint(response)
      })
    }
    
    
    
    pushVC()
  }
  
  @objc func keyboardWillShow(notification : NSNotification) {
    // 키보드 사이즈 가져오기
//    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//      print("keyboardSize.height : \(keyboardSize.height)")
//      print("searchButton.frame.origin.y : \(searchButton.frame.origin.y)")
//
//      if (keyboardSize.height < searchButton.frame.origin.y) {
//        let distance = keyboardSize.height - searchButton.frame.origin.y
//        self.view.fra me.origin.y = distance
//      }
//    }
  }
  
  @objc func keyboardWillHide(notificatino : NSNotification) {
    // 원상태 복귀
    self.view.frame.origin.y = 0
  }
}

  //MARK: - UISearchBarDelegate
extension HomeViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    guard let userInputString = searchBar.text else { return }
    
    if userInputString.isEmpty {
      self.view.makeToast("검색 키워드를 입력해주세요.🧐", duration: 1.0, position: .center)
    } else {
      pushVC()
      searchBar.resignFirstResponder()
    }
    
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if (searchText.isEmpty) {
      self.searchButton.isHidden = true
      searchBar.resignFirstResponder() // 포커싱 해제
    } else {
      self.searchButton.isHidden = false
    }
  }

  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let inputTextCount = searchBar.text?.appending(text).count ?? 0  // 글자 수

    if (inputTextCount >= 12) {
      self.view.makeToast("12자 까지만 입력가능합니다.😓", duration: 1.0, position: .center)
    }
    return inputTextCount <= 12
  }
}

  //MARK: - UITapGestureRecognizerDelegate
extension HomeViewController : UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    print("gestureRecognizer")
    // 터치로 들어온 뷰가 밑에것들이면
    if (touch.view?.isDescendant(of: searchFilterSegment) == true ) {
      print("세그먼트가 터치")
      return false
    } else if (touch.view?.isDescendant(of: searchBar) == true ) {
      print("서치바가 터치")
      return false
    } else {
      view.endEditing(true) // 화면edit 이 끝나서 키보드가 내려간다.
      return true
    }
  }
}
