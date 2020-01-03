//
//  WeaponPopUPViewController.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/18.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit
import RealmSwift


class WeaponPopUPViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchElementTextField: UITextField!
    
    
    
    var computedCellSize: CGSize?
    var name = [String]()
    var attribute = [String]()
    var species = [String]()
    var f_skill = [String]()
    var s_skill = [String]()
    var minhp = [String]()
    var minatk = [String]()
    var maxhp1 = [String]()
    var maxatk1 = [String]()
    var maxhp2 = [String]()
    var maxatk2 = [String]()
    var maxhp3 = [String]()
    var maxatk3 = [String]()
    var f_skill_effect = [String]()
    var s_skill_effect = [String]()
    var pre_f_skill_effect = [String]()
    var pre_s_skill_effect = [String]()
    var f_skill_detail1 = [String]()
    var f_skill_detail2 = [String]()
    var s_skill_detail1 = [String]()
    var s_skill_detail2 = [String]()
    var pre_f_skill_detail1 = [String]()
    var pre_f_skill_detail2 = [String]()
    var pre_s_skill_detail1 = [String]()
    var pre_s_skill_detail2 = [String]()
    
    var name_searched:String = ""
    var element:String = ""
    let elementArray = ["火", "水", "土", "風", "闇", "光"]
    var pickerView: UIPickerView = UIPickerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchElementTextField.delegate = self
        loadRealm()
        
        
        collectionview.delegate = self
        collectionview.dataSource = self
        initCollectionView()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        PickerViewSetting()

        // Do any additional setup after loading the view.
    }
    
    func loadRealm(){
        loadRealm_no_released()
        loadRealm_released4()
        loadRealm_released5()
    }
    
    func loadRealm_no_released(){
        name = [String]()
        attribute = [String]()
        species = [String]()
        f_skill = [String]()
        s_skill = [String]()
        minhp = [String]()
        minatk = [String]()
        maxhp1 = [String]()
        maxatk1 = [String]()
        maxhp2 = [String]()
        maxatk2 = [String]()
        maxhp3 = [String]()
        maxatk3 = [String]()
        f_skill_effect = [String]()
        s_skill_effect = [String]()
        pre_f_skill_effect = [String]()
        pre_s_skill_effect = [String]()
        f_skill_detail1 = [String]()
        f_skill_detail2 = [String]()
        s_skill_detail1 = [String]()
        s_skill_detail2 = [String]()
        pre_f_skill_detail1 = [String]()
        pre_f_skill_detail2 = [String]()
        pre_s_skill_detail1 = [String]()
        pre_s_skill_detail2 = [String]()
        
        var config = Realm.Configuration()
        let path = Bundle.main.path(forResource: "weapon", ofType: "realm")
        
        let name_pred = name_searched
        
        config.fileURL = URL(string:path!)
        config.readOnly = true
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        
        var results = realm.objects(weapon_ssr_list_effect.self).filter("name LIKE %@", "*\(name_pred)*")
        
        
        if element != ""{
            results = results.filter("attribute LIKE %@", "*\(element)*")
        }
        
        
        for result in results{
            name.append(result.name!)
            attribute.append(result.attribute!)
            species.append(result.species!)
            f_skill.append(result.f_skill!)
            s_skill.append(result.s_skill!)
            minhp.append(result.minhp!)
            minatk.append(result.minatk!)
            maxhp1.append(result.maxhp1!)
            maxatk1.append(result.maxatk1!)
            maxhp2.append("0")
            maxatk2.append("0")
            maxhp3.append("0")
            maxatk3.append("0")
            f_skill_effect.append(result.f_skill_effect!)
            s_skill_effect.append(result.s_skill_effect!)
            pre_f_skill_effect.append("0")
            pre_s_skill_effect.append("0")
            f_skill_detail1.append(result.f_skill_detail1!)
            f_skill_detail2.append(result.f_skill_detail2!)
            s_skill_detail1.append(result.s_skill_detail1!)
            s_skill_detail2.append(result.s_skill_detail2!)
            pre_f_skill_detail1.append("0")
            pre_f_skill_detail2.append("0")
            pre_s_skill_detail1.append("0")
            pre_s_skill_detail2.append("0")
            
        }
        
    }
    
    func loadRealm_released4(){
        var config = Realm.Configuration()
        let path = Bundle.main.path(forResource: "weapon_released4", ofType: "realm")
        
        let name_pred = name_searched
        
        config.fileURL = URL(string:path!)
        config.readOnly = true
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        
        var results = realm.objects(weapon_ssr_released4_list_effect.self).filter("name LIKE %@", "*\(name_pred)*")
        
        
        if element != ""{
            results = results.filter("attribute LIKE %@", "*\(element)*")
        }
        
        
        for result in results{
            name.append(result.name!)
            attribute.append(result.attribute!)
            species.append(result.species!)
            f_skill.append(result.f_skill!)
            s_skill.append(result.s_skill!)
            minhp.append(result.minhp!)
            minatk.append(result.minatk!)
            maxhp1.append(result.maxhp1!)
            maxatk1.append(result.maxatk1!)
            maxhp2.append(result.maxhp2!)
            maxatk2.append(result.maxatk2!)
            maxhp3.append("0")
            maxatk3.append("0")
            f_skill_effect.append(result.f_skill_effect!)
            s_skill_effect.append(result.s_skill_effect!)
            pre_f_skill_effect.append(result.pre_f_skill_effect!)
            pre_s_skill_effect.append(result.pre_s_skill_effect!)
            f_skill_detail1.append(result.f_skill_detail1!)
            f_skill_detail2.append(result.f_skill_detail2!)
            s_skill_detail1.append(result.s_skill_detail1!)
            s_skill_detail2.append(result.s_skill_detail2!)
            pre_f_skill_detail1.append(result.pre_f_skill_detail1!)
            pre_f_skill_detail2.append(result.pre_f_skill_detail2!)
            pre_s_skill_detail1.append(result.pre_s_skill_detail1!)
            pre_s_skill_detail2.append(result.pre_s_skill_detail2!)
            
        }
        
    }
    
    func loadRealm_released5(){
        var config = Realm.Configuration()
        let path = Bundle.main.path(forResource: "weapon_released5", ofType: "realm")
        
        let name_pred = name_searched
        
        config.fileURL = URL(string:path!)
        config.readOnly = true
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        
        var results = realm.objects(weapon_ssr_released5_list_effect.self).filter("name LIKE %@", "*\(name_pred)*")
        
        
        if element != ""{
            results = results.filter("attribute LIKE %@", "*\(element)*")
        }
        
        
        for result in results{
            name.append(result.name!)
            attribute.append(result.attribute!)
            species.append(result.species!)
            f_skill.append(result.f_skill!)
            s_skill.append(result.s_skill!)
            minhp.append(result.minhp!)
            minatk.append(result.minatk!)
            maxhp1.append(result.maxhp1!)
            maxatk1.append(result.maxatk1!)
            maxhp2.append(result.maxhp2!)
            maxatk2.append(result.maxatk2!)
            maxhp3.append(result.maxhp3!)
            maxatk3.append(result.maxatk3!)
            f_skill_effect.append(result.f_skill_effect!)
            s_skill_effect.append(result.s_skill_effect!)
            pre_f_skill_effect.append(result.pre_f_skill_effect!)
            pre_s_skill_effect.append(result.pre_s_skill_effect!)
            f_skill_detail1.append(result.f_skill_detail1!)
            f_skill_detail2.append(result.f_skill_detail2!)
            s_skill_detail1.append(result.s_skill_detail1!)
            s_skill_detail2.append(result.s_skill_detail2!)
            pre_f_skill_detail1.append(result.pre_f_skill_detail1!)
            pre_f_skill_detail2.append(result.pre_f_skill_detail2!)
            pre_s_skill_detail1.append(result.pre_s_skill_detail1!)
            pre_s_skill_detail2.append(result.pre_s_skill_detail2!)
            
        }
        
    }
    
    //Cell Number
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    //Cell Content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeaponCollectionViewCell", for: indexPath as IndexPath) as! WeaponCollectionViewCell
        
        cell.WeaponName.text = name[indexPath.row]
        cell.Skill1.text = f_skill[indexPath.row]
        
        if s_skill[indexPath.row] != "0"{
            cell.Skill2.text = s_skill[indexPath.row]
        }else{
            cell.Skill2.text = ""
        }
        
        let element = attribute[indexPath.row]
        
        if element == "火"{
            cell.Element.setImage(UIImage(named:"fire")!, for: .normal)
        }else if element == "水"{
            cell.Element.setImage(UIImage(named:"water")!, for: .normal)
        }else if element == "風"{
            cell.Element.setImage(UIImage(named:"wind")!, for: .normal)
        }else if element == "土"{
            cell.Element.setImage(UIImage(named:"soil")!, for: .normal)
        }else if element == "闇"{
            cell.Element.setImage(UIImage(named:"dark")!, for: .normal)
        }else if element == "光"{
            cell.Element.setImage(UIImage(named:"light")!, for: .normal)
        }
        
        return cell
    }
    
    //Cell Selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Weapon", bundle: nil)
        
        let contentVC = storyboard.instantiateViewController(withIdentifier: "WeaponSelectPopUp") as! WeaponSelectPopUpViewController
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        
        // スタイルの指定
        contentVC.modalPresentationStyle = .popover
        // サイズの指定
        contentVC.preferredContentSize = CGSize(width: 250, height: 130)
        // 表示するViewの指定
        contentVC.popoverPresentationController?.sourceView = cell
        // ピヨッと表示する位置の指定
        contentVC.popoverPresentationController?.sourceRect = (cell?.contentView.bounds)!
        // 矢印が出る方向の指定
        contentVC.popoverPresentationController?.permittedArrowDirections = .up
        // デリゲートの設定
        contentVC.popoverPresentationController?.delegate = self
        //表示
        present(contentVC, animated: true, completion: nil)
        
        contentVC.name = name[indexPath.row]
        contentVC.attribute = attribute[indexPath.row]
        contentVC.species = species[indexPath.row]
        contentVC.f_skill = f_skill[indexPath.row]
        contentVC.s_skill = s_skill[indexPath.row]
        contentVC.minhp = minhp[indexPath.row]
        contentVC.minatk = minatk[indexPath.row]
        contentVC.maxhp1 = maxhp1[indexPath.row]
        contentVC.maxatk1 = maxatk1[indexPath.row]
        contentVC.maxhp2 = maxhp2[indexPath.row]
        contentVC.maxatk2 = maxatk2[indexPath.row]
        contentVC.maxhp3 = maxhp3[indexPath.row]
        contentVC.maxatk3 = maxatk3[indexPath.row]
        contentVC.f_skill_effect = f_skill_effect[indexPath.row]
        contentVC.s_skill_effect = s_skill_effect[indexPath.row]
        contentVC.f_skill_detail1 = f_skill_detail1[indexPath.row]
        contentVC.s_skill_detail1 = s_skill_detail1[indexPath.row]
        contentVC.f_skill_detail2 = f_skill_detail2[indexPath.row]
        contentVC.s_skill_detail2 = s_skill_detail2[indexPath.row]
        contentVC.pre_f_skill_effect = pre_f_skill_effect[indexPath.row]
        contentVC.pre_s_skill_effect = pre_s_skill_effect[indexPath.row]
        contentVC.pre_f_skill_detail1 = pre_f_skill_detail1[indexPath.row]
        contentVC.pre_s_skill_detail1 = pre_s_skill_detail1[indexPath.row]
        contentVC.pre_f_skill_detail2 = pre_f_skill_detail2[indexPath.row]
        contentVC.pre_s_skill_detail2 = pre_s_skill_detail2[indexPath.row]
        
    }
    
    private func initCollectionView() {
        self.collectionview.register(UINib(nibName: "WeaponCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeaponCollectionViewCell")
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name_searched = textField.text!
        loadRealm()
        collectionview.reloadData()
        print(name_searched)
        textField.endEditing(true)
        return true
    }
    
    
    // Picker View
    func PickerViewSetting(){
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, flexibleItem, doneItem], animated: true)
        toolbar.sizeToFit()
        
        self.searchElementTextField.inputView = pickerView
        self.searchElementTextField.inputAccessoryView = toolbar
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return elementArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return elementArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.searchElementTextField.text = elementArray[row]
    }
    
    @objc func cancel() {
        self.searchElementTextField.text = ""
        self.searchElementTextField.endEditing(true)
    }
    
    @objc func done() {
        element = searchElementTextField.text!
        loadRealm()
        collectionview.reloadData()
        self.searchElementTextField.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    
    /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        name_searched = textField.text!
        loadRealm()
        collectionview.reloadData()
        print(name_searched)
        return true
    }
    */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeaponPopUPViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 一度計算したらキャッシュし、負荷を軽減
        // TODO: landscape表示に対応している場合は再計算を行うこと
        if let cellSize = self.computedCellSize {
            return cellSize
        } else {
            // PropotionalSizingCell.nibから原型セルを生成し、2列表示に適切なサイズを求める
            guard
                let prototypeCell = WeaponCollectionViewCell.nib.instantiate(withOwner: nil, options: nil).first as? WeaponCollectionViewCell,
                let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
                else {
                    fatalError()
            }
            
            let cellSize = prototypeCell.propotionalScaledSize(for: flowLayout, numberOfColumns: 2)
            self.computedCellSize = cellSize
            
            return cellSize
        }
    }
}

private extension WeaponCollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
