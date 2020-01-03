//
//  WeaponSelectViewController.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/17.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit
import RealmSwift


class WeaponSelectViewController: UIViewController,UITextFieldDelegate, UIPopoverPresentationControllerDelegate, UITabBarDelegate, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate{
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var HPTextField: UITextField!
    @IBOutlet weak var ATKTextField: UITextField!
    @IBOutlet weak var Skill1ETextField: UITextField!
    @IBOutlet weak var Skill1CTextField: UITextField!
    @IBOutlet weak var Skill2ETextField: UITextField!
    @IBOutlet weak var Skill2CTextField: UITextField!
    @IBOutlet weak var SLvTextField: UITextField!
    @IBOutlet weak var PopUpBar: UIView!
    var userDefaults = UserDefaults.standard
    var WeaponNumber:Int = 0
    
    let elementArray = ["火", "水", "土", "風", "闇", "光"]
    let SkillArray:[String] = SkillPickerArray().returnSkillArray()
    var pickerView1: UIPickerView = UIPickerView()
    var pickerView2: UIPickerView = UIPickerView()
    var pickerView3: UIPickerView = UIPickerView()
    var pickerView4: UIPickerView = UIPickerView()
    var pickerView5: UIPickerView = UIPickerView()
    var textFieldtag:Int = 0
    let CulcFunctions = WeaponCulc()
    
    var name = ""
    var attribute = ""
    var species = ""
    /*
    var species = ""
    var rank = ""
    var f_skill = ""
    var s_skill = ""
    var minhp = ""
    var minatk = ""
    var maxhp1 = ""
    var maxatk1 = ""
    var f_skill_effect = ""
    var s_skill_effect = ""
    var f_skill_detail1 = ""
    var s_skill_detail1 = ""
    var f_skill_detail2 = ""
    var s_skill_detail2 = ""
    var pre_f_skill_effect = ""
    var pre_s_skill_effect = ""
    var pre_f_skill_detail1 = ""
    var pre_s_skill_detail1 = ""
    var pre_f_skill_detail2 = ""
    var pre_s_skill_detail2 = ""
    */
    
    var f_skill = ""
    var s_skill = ""
    var f_skill_element = ""
    var s_skill_element = ""
    var f_skill_amount1 = ""
    var s_skill_amount1 = ""
    var f_skill_amount2 = ""
    var s_skill_amount2 = ""
    var SLv = ""
    var Lv = ""
    var atk = ""
    var hp = ""
    var SLvArray = SkillPickerArray().returnSLvArray()
    var WeaponCell = [String]()
    
    let WeaponSelectPopUp:WeaponSelectPopUpViewController = WeaponSelectPopUpViewController()
    var observer: NSObjectProtocol?
    
    var WeaponCells: [[String]] = [[String]]()
    
    var txtActiveField = UITextField()
    
    var f_skillArray = [String]()
    var s_skillArray = [String]()
    var f_skill_detail1Array = [String]()
    var f_skill_detail2Array = [String]()
    var s_skill_detail1Array = [String]()
    var s_skill_detail2Array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView1.tag = 1
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.tag = 2
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3.tag = 3
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        pickerView4.tag = 4
        pickerView4.delegate = self
        pickerView4.dataSource = self
        
        pickerView5.tag = 5
        pickerView5.delegate = self
        pickerView5.dataSource = self
        
        if self.userDefaults.object(forKey: "WeaponCell") != nil{
            self.WeaponCells = self.userDefaults.array(forKey: "WeaponCell") as! [[String]]
        }else{
            self.WeaponCells = [[String]]()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.configureObserver()
        
        self.NameTextField.tag = 1
        self.Skill1ETextField.tag = 2
        self.Skill1CTextField.tag = 3
        self.Skill2ETextField.tag = 4
        self.Skill2CTextField.tag = 5
        self.SLvTextField.tag = 6
        PickerViewSetting()
        observer = NotificationCenter.default.addObserver(forName: .saveWeaponName, object: nil, queue: OperationQueue.main){(notification) in
            let PopUpVC = notification.object as! WeaponSelectPopUpViewController
            let atk = String(PopUpVC.atk)
            let hp = String(PopUpVC.hp)
            self.ATKTextField.text = atk
            self.HPTextField.text = hp
            self.NameTextField.text = PopUpVC.name
            self.Skill1ETextField.text = PopUpVC.f_skill_element
            self.Skill1CTextField.text = PopUpVC.f_skill
            self.Skill2ETextField.text = PopUpVC.s_skill_element
            self.Skill2CTextField.text = PopUpVC.s_skill
            self.SLvTextField.text = PopUpVC.SLv
            self.name = String(PopUpVC.name)
            self.attribute = String(PopUpVC.attribute)
            self.Lv = String(PopUpVC.Lv)
            self.atk = String(PopUpVC.atk)
            self.hp = String(PopUpVC.hp)
            self.SLv = String(PopUpVC.SLv)
            self.f_skill = String(PopUpVC.f_skill)
            self.s_skill = String(PopUpVC.s_skill)
            self.f_skill_element = String(PopUpVC.f_skill_element)
            self.s_skill_element = String(PopUpVC.s_skill_element)
            self.f_skill_amount1 = String(PopUpVC.f_skill_amount1)
            self.s_skill_amount1 = String(PopUpVC.s_skill_amount1)
            self.f_skill_amount2 = String(PopUpVC.f_skill_amount2)
            self.s_skill_amount2 = String(PopUpVC.s_skill_amount2)
            self.species = String(PopUpVC.species)
            self.WeaponNumber = PopUpVC.WeaponNumber
        }
        //NotificationCenter.default.addObserver(self, selector: #selector(TextFieldChanged), name: .saveWeaponName, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //self.removeObserver()
        if let observer = observer{
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NameTextField.text = name
        TextFieldRound(textField: NameTextField)
        TextFieldRound(textField: HPTextField)
        TextFieldRound(textField: ATKTextField)
        TextFieldRound(textField: Skill1ETextField)
        TextFieldRound(textField: Skill1CTextField)
        TextFieldRound(textField: Skill2ETextField)
        TextFieldRound(textField: Skill2CTextField)
        TextFieldRound(textField: SLvTextField)
        self.NameTextField.delegate = self
        self.HPTextField.delegate  = self
        self.ATKTextField.delegate = self
        self.Skill1ETextField.delegate = self
    }
    
    func TextFieldRound(textField: UITextField){
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor(red: 112.0 / 255.0, green: 112.0 / 255.0, blue: 112.0 / 255.0, alpha: 1).cgColor
        textField.layer.borderWidth  = 1.0
        textField.layer.masksToBounds = true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldtag = textField.tag
        if textFieldtag == 1{
            let storyboard: UIStoryboard = UIStoryboard(name: "Weapon", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "WeaponPopUp")
            
            let contentVC = nextView
            // スタイルの指定
            contentVC.modalPresentationStyle = .popover
            // サイズの指定
            //contentVC.preferredContentSize = CGSize(width: 300, height: 537)
            // 表示するViewの指定
            contentVC.popoverPresentationController?.sourceView = PopUpBar
            // ピヨッと表示する位置の指定
            contentVC.popoverPresentationController?.sourceRect = PopUpBar.bounds
            // 矢印が出る方向の指定
            contentVC.popoverPresentationController?.permittedArrowDirections = .up
            // デリゲートの設定
            contentVC.popoverPresentationController?.delegate = self
            //表示
            present(contentVC, animated: true, completion: nil)
            
            return false
            
        }else{
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldtag = textField.tag
        print(textFieldtag)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
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
        
        self.Skill1ETextField.inputView = pickerView1
        self.Skill1ETextField.inputAccessoryView = toolbar
        self.Skill2ETextField.inputView = pickerView2
        self.Skill2ETextField.inputAccessoryView = toolbar
        
        self.Skill1CTextField.inputView = pickerView3
        self.Skill1CTextField.inputAccessoryView = toolbar
        self.Skill2CTextField.inputView = pickerView4
        self.Skill2CTextField.inputAccessoryView = toolbar
        self.SLvTextField.inputView = pickerView5
        self.SLvTextField.inputAccessoryView = toolbar
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) || (pickerView.tag == 2){
            return elementArray.count
        }else if pickerView.tag == 3 || (pickerView.tag == 4){
            return SkillArray.count
        }else{
            return SLvArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 || (pickerView.tag == 2){
            return elementArray[row]
        }else if pickerView.tag == 3 || (pickerView.tag == 4){
            return SkillArray[row]
        }else{
            return SLvArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.Skill1ETextField.text = elementArray[row]
        }else if pickerView.tag == 2{
            self.Skill2ETextField.text = elementArray[row]
        }else if pickerView.tag == 3{
            self.Skill1CTextField.text = SkillArray[row]
        }else if pickerView.tag == 4{
            return self.Skill2CTextField.text = SkillArray[row]
        }else{
            return self.SLvTextField.text = SLvArray[row]
        }
    }
    
    @objc func cancel(){
        let targetTxtFld = self.view.viewWithTag(textFieldtag) as? UITextField
        targetTxtFld?.text = ""
        view.endEditing(true)
    }
    
    @objc func done(){
        view.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @IBAction func AddWeaponTouchUpInside(_ sender: Any) {
        var Bool = "false"
        loadRealm()
        if SLv != SLvTextField.text{
            SLv = SLvTextField.text ?? "10"
        }
        
        if f_skill_element != Skill1ETextField.text{
            f_skill_element = Skill1ETextField.text ?? "なし"
        }
        
        if f_skill != Skill1CTextField.text{
            f_skill = Skill1CTextField.text ?? "なし"
            for i in 0..<f_skillArray.count{
                if f_skill == CulcFunctions.CheckSkill_Changed(skill_detail: f_skill_detail1Array[i]){
                    f_skill_amount1 = CulcFunctions.returnSkillEffectAmount_Changed(skill_detail: f_skill_detail1Array[i], SLv: Int(SLv) ?? 10)
                    f_skill_amount2 = CulcFunctions.returnSkillEffectAmount_Changed(skill_detail: f_skill_detail2Array[i], SLv: Int(SLv) ?? 10)
                    break
                }else if f_skill == "オメガ闘争"{
                    f_skill_amount1 = "0"
                    f_skill_amount2 = "0"
                }
            }
        }
        
        if s_skill_element != Skill2ETextField.text{
            s_skill_element = Skill2ETextField.text ?? "なし"
        }
        
        if s_skill != Skill2CTextField.text{
            s_skill = Skill2CTextField.text ?? "なし"
            for i in 0..<s_skillArray.count{
                if s_skill == CulcFunctions.CheckSkill_Changed(skill_detail: s_skill_detail1Array[i]){
                    s_skill_amount1 = CulcFunctions.returnSkillEffectAmount_Changed(skill_detail: s_skill_detail1Array[i], SLv: Int(SLv) ?? 10)
                    s_skill_amount2 = CulcFunctions.returnSkillEffectAmount_Changed(skill_detail: s_skill_detail2Array[i], SLv: Int(SLv) ?? 10)
                    break
                }else if s_skill == "オメガ闘争"{
                    s_skill_amount1 = "0"
                    s_skill_amount2 = "0"
                }
            }
        }
        
        let WeaponCellNumber = WeaponCells.count+WeaponNumber
        if WeaponCellNumber <= 10{
            Bool = "true"
        }
        
        WeaponCell = [name, species, Lv, SLv, atk, hp, f_skill_element, s_skill_element, f_skill, s_skill, f_skill_amount1, f_skill_amount2, s_skill_amount1, s_skill_amount2, Bool]
        
        
        
        for i in 0..<WeaponNumber{
            print(i)
            WeaponCells.append(WeaponCell)
        }
        userDefaults.set(WeaponCells, forKey: "WeaponCell")
        NotificationCenter.default.post(name: .reloadData, object: self)
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Returnキーを押したときにキーボードを下げる
        return true
    }
    
    func loadRealm(){
        loadRealm_no_released()
        loadRealm_released4()
        loadRealm_released5()
    }
    
    
    func loadRealm_no_released(){
        f_skillArray = [String]()
        s_skillArray = [String]()
        f_skill_detail1Array = [String]()
        f_skill_detail2Array = [String]()
        s_skill_detail1Array = [String]()
        s_skill_detail2Array = [String]()
        
        var config = Realm.Configuration()
        let path = Bundle.main.path(forResource: "weapon", ofType: "realm")
        
        config.fileURL = URL(string:path!)
        config.readOnly = true
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        
        let results = realm.objects(weapon_ssr_list_effect.self)
        
        
        
        for result in results{
            f_skillArray.append(result.f_skill!)
            s_skillArray.append(result.s_skill!)
            f_skill_detail1Array.append(result.f_skill_detail1!)
            f_skill_detail2Array.append(result.f_skill_detail2!)
            s_skill_detail1Array.append(result.s_skill_detail1!)
            s_skill_detail2Array.append(result.s_skill_detail2!)
            
        }
        
    }
    
    func loadRealm_released4(){
        var config = Realm.Configuration()
        let path = Bundle.main.path(forResource: "weapon_released4", ofType: "realm")
        
        
        config.fileURL = URL(string:path!)
        config.readOnly = true
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        
        let results = realm.objects(weapon_ssr_released4_list_effect.self)
        
        
        for result in results{
            f_skillArray.append(result.f_skill!)
            s_skillArray.append(result.s_skill!)
            f_skill_detail1Array.append(result.f_skill_detail1!)
            f_skill_detail2Array.append(result.f_skill_detail2!)
            s_skill_detail1Array.append(result.s_skill_detail1!)
            s_skill_detail2Array.append(result.s_skill_detail2!)
            
        }
        
    }
    
    func loadRealm_released5(){
        var config = Realm.Configuration()
        let path = Bundle.main.path(forResource: "weapon_released5", ofType: "realm")
        
        config.fileURL = URL(string:path!)
        config.readOnly = true
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        
        let results = realm.objects(weapon_ssr_released5_list_effect.self)
        
        
        
        for result in results{
            f_skillArray.append(result.f_skill!)
            s_skillArray.append(result.s_skill!)
            f_skill_detail1Array.append(result.f_skill_detail1!)
            f_skill_detail2Array.append(result.f_skill_detail2!)
            s_skill_detail1Array.append(result.s_skill_detail1!)
            s_skill_detail2Array.append(result.s_skill_detail2!)
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
