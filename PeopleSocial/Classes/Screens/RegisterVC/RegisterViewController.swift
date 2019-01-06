//
//  RegisterViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, NibLoadable {

  private let models: [HeaderModel] = [.info, .sex, .bithday]
  
  @IBOutlet weak var tableView: UITableView!
  
  private let dataPickerView: UIDatePicker = { // создали пикер
    let picker = UIDatePicker()
    picker.maximumDate = Date()
    return picker
  }()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    title = "Registration"

    Decorator.decorate(vc: self)
    registerCells()
    delegating()
    configureDatePickerView()

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated) // приячим навигейшен бар
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func delegating() { //подписали делегаты
    tableView.delegate = self
    tableView.dataSource = self
  }
  private func registerCells() { // регистрируем ячейку
    tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
    
    tableView.register(SegmentTableViewCell.nib, forCellReuseIdentifier: SegmentTableViewCell.name)
    
    tableView.register(TextFieldTableViewCell.nib, forCellReuseIdentifier: TextFieldTableViewCell.name)

  }
  private func configureDatePickerView() { // отображает пикер вю
    dataPickerView.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
  }
  @objc private func datePickerChanged(sender: UIDatePicker) {
    let date = sender.date
    print(date)
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
      vc.tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1) // цвет таблицы
      vc.navigationController?.navigationBar.prefersLargeTitles = true
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
  }                                    // задаем ячейку
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.section].cellModels[indexPath.row]
    switch model {
    case .userInfo:
      if let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.name, for: indexPath) as? InfoUserTableViewCell {
        return cell
      }
    case .sex:
      if let cell = tableView.dequeueReusableCell(withIdentifier: SegmentTableViewCell.name, for: indexPath) as? SegmentTableViewCell {
        cell.indexChanged = {
          index in
          print(index)
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
