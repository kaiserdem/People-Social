//
//  RegisterViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import ARSLineProgress

class RegisterViewController: UIViewController, NibLoadable {

  private let sexModels: [Sex] = [.male, .female]
  private let models: [HeaderModel] = [.info, .sex, .bithday]
  private var registerModel = RegisterModel()
  @IBOutlet weak var tableView: UITableView!
  
  private let dataPickerView: UIDatePicker = { // создали пикер
    let picker = UIDatePicker()
    picker.maximumDate = Date()
    return picker
  }()
  
  override func viewDidLoad() {
        super.viewDidLoad()

    Decorator.decorate(vc: self)
    registerCells()
    delegating()
    configureDatePickerView()
    addRightBarButton()
    updateDoneButtonStatus() // статус кнопки Done
    addHeaderView()
  }
  private func addHeaderView() { // добавить титул, верхний елемент
    let headerView = TitleHeaderView.loadFromNib()
    headerView.set(text: "New Account")
    let height: CGFloat =  100
    let width = view.frame.size.width
    headerView.frame.size = CGSize(width: width, height: height)
    tableView.tableHeaderView = headerView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated) // приячим навигейшен бар
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func delegating() { //подписали делегаты
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func photoViewClicked() { // касание на фото вю
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary // показывать фотоальбом
    present(imagePickerController, animated: true, completion: nil)// показываем контроллер
  }
  
  private func registerCells() { // регистрируем ячейку
   // tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
    
    tableView.register(SegmentTableViewCell.nib, forCellReuseIdentifier: SegmentTableViewCell.name)
    
    tableView.register(TextFieldTableViewCell.nib, forCellReuseIdentifier: TextFieldTableViewCell.name)
  }
  
  private func addRightBarButton() { // приавая кнопка мыши
    let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonClicked(sender:)))
    navigationItem.rightBarButtonItem = barButton
  }
  private func updateDoneButtonStatus() { // кнопка Done работает когда поля заполнены
    navigationItem.rightBarButtonItem?.isEnabled = registerModel.isFiled
  }
  @objc private func rightBarButtonClicked(sender: UIBarButtonItem) { // кнопка готово
    ARSLineProgress.show()  //
    AuthManager.shared.register(with: registerModel) { result in // вызываем функцию регистрации
      ARSLineProgress.hide()
      
      switch result {
      case .success(_):
        StartRouter.shared.routeAfterSuccess(from: self)
        SecureStorageManager.shared.save(email: self.registerModel.email, password: self.registerModel.password, completionHandler: { (error) in
          if let error = error {
            print(String(describing: error.errorDescription))
          }
        })
      case .failure(let error):
        self.showAlert(with: "Error", and: error.localizedDescription)

      }
    }
  }
  private func configureDatePickerView() { // возраст,отображает пикер вю c
    dataPickerView.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
  }
  
  @objc private func datePickerChanged(sender: UIDatePicker) {
    let date = sender.date
    registerModel.birthday = date
    updateDoneButtonStatus() // статус кнопки Done
  }
}

extension RegisterViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
             // берем выбраное изображение
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil) // скрываем выбор фото
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      return
    }
    registerModel.photo = image
    updateDoneButtonStatus() // статус кнопки Done
    tableView.reloadData()   // обновляем таблицу
    ARSLineProgress.show()   // показать прогресс 
    StorageManager.shared.upload(photo: image, by: registerModel) {
    ARSLineProgress.hide()   // скрыть прогресс
    }
  }
}
extension RegisterViewController {
  fileprivate enum CellModel { // модель ячеек
    case userInfo
    case sex
    case bithday
  }
  fileprivate enum HeaderModel: CellHeaderProtocol {
    typealias CellType = CellModel
    case sex
    case info
    case bithday
    
    var cellModels: [RegisterViewController.CellModel] {
      switch self {
      case .sex: return [.sex]
      case .info: return [.userInfo]
      case .bithday: return [.bithday]
        
      }
    }
  }
}
extension RegisterViewController {
  private static let tableViewTopInsert: CGFloat = 16  //отступ сверху
  fileprivate class Decorator {
    static func decorate(vc: RegisterViewController) {
      vc.tableView.keyboardDismissMode = .onDrag // по свайпу клавиатура скрываеться
      vc.tableView.separatorColor = .clear // края таблицы не видно
      vc.tableView.backgroundColor = .white // цвет таблицы
      vc.navigationController?.navigationBar.prefersLargeTitles = true
      vc.navigationController?.navigationBar.makeClear() // прозрачный нав бар
      vc.tableView.contentInset = UIEdgeInsets(top: tableViewTopInsert, left: 0, bottom: 0, right: 0)
    }
  }
}
extension RegisterViewController: UITableViewDelegate {
  // высота для ячейки
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let model = models[indexPath.section].cellModels[indexPath.row]
    switch model {
    case .userInfo: return 100
    case .sex, .bithday: return 44
    }
  }
}

extension RegisterViewController: UITableViewDataSource {
                        // задаем ячейку для хедера
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerModel = models[section]
    switch headerModel {
    case .sex:
      let view = HeaderTitleView.loadFromNib() // эту ячейку по протоколу
      view.set(title: "Gender:") //функция для тайтла
      return view
    default: return nil
    }
  }                          // высота хедера
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let headerModel = models[section]
    switch headerModel {
    case .sex, .bithday: return 44
    default: return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.section].cellModels[indexPath.row]
    switch model {
    case .userInfo:
      return UITableViewCell()
//      if let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.name, for: indexPath) as? InfoUserTableViewCell {
//        cell.emailTextChanged = {
//          text in
//          self.registerModel.email = text
//          self.updateDoneButtonStatus() // статус кнопки Done
//        }
//        cell.passwordTextChanged = {
//          text in
//          self.registerModel.password = text
//          self.updateDoneButtonStatus() // статус кнопки Done
//
//        }
//        cell.photoViewClicked = self.photoViewClicked // картинка по касанию
//        cell.set(image: registerModel.photo) // картинка из модели
//        return cell
//      }
    case .sex:
      if let cell = tableView.dequeueReusableCell(withIdentifier: SegmentTableViewCell.name, for: indexPath) as? SegmentTableViewCell {
        cell.set(titels: sexModels.map{$0.rawValue.capitalized})
        cell.indexChanged = {
          index in
          let sex = self.sexModels[index]
          self.registerModel.sex = sex
          self.updateDoneButtonStatus() // статус кнопки Done
        }
        return cell
      }
    case .bithday:
      if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
        cell.textField.inputView = dataPickerView // вызываем пикер вю
        return cell
  
      }
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models[section].cellModels.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return models.count
  }
}
