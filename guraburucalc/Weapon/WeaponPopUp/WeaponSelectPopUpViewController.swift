//
//  WeaponSelectPopUpViewController.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/18.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit



class WeaponSelectPopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var LvTextField: UITextField!
    @IBOutlet weak var SLvTextField: UITextField!
    @IBOutlet weak var plusTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var pickerView1: UIPickerView = UIPickerView()
    var pickerView2: UIPickerView = UIPickerView()
    var pickerView3: UIPickerView = UIPickerView()
    let CulcFunctions = WeaponCulc()
    
    var name = ""
    var attribute = ""
    var species = ""
    var rank = ""
    var f_skill = ""
    var s_skill = ""
    var minhp = ""
    var minatk = ""
    var maxhp1 = ""
    var maxatk1 = ""
    var maxhp2 = ""
    var maxatk2 = ""
    var maxhp3 = ""
    var maxatk3 = ""
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
    var atk:Int = 0
    var hp:Int = 0
    var maxLv:Int = 0
    var SLv = "SLv10"
    var Lv = "3凸(100Lv)"
    var plus:Int = 0
    var f_skill_amount1 = ""
    var s_skill_amount1 = ""
    var f_skill_amount2 = ""
    var s_skill_amount2 = ""
    var f_skill_element = ""
    var s_skill_element = ""
    var Weapon = [String]()
    var computedCellSize: CGSize?
    var LvArray = ["無凸(40Lv)", "1凸(60Lv)", "2凸(80Lv)", "3凸(100Lv)"]
    var SLvArray = [String]()
    var plusArray = ["+0", "+99"]
    var NumberArray = ["1本","2本","3本","4本","5本","6本","7本","8本","9本","10本"]
    var WeaponNumber:Int = 0
    
    func PickerViewArrayShape(){
        if maxhp2 != "0"{
            LvArray.append("4凸(150Lv)")
            if maxhp3 != "0"{
                LvArray.append("5凸(200Lv)")
            }
        }
        
        
        if f_skill_detail1 != "0" && f_skill_detail1 != "0.0"{
            for i in 1..<21{
                let S_effct = f_skill_detail1.split(separator:",")[i+1]
                print(S_effct)
                if S_effct != "0" && S_effct != "0.0"{
                    SLvArray.append("SLv"+"\(i)")
                }
            }
        }
        if SLvArray == [] && s_skill_detail1 != "0" && s_skill_detail1 != "0.0"{
            for i in 1..<21{
                let S_effct = s_skill_detail1.split(separator:",")[i+1]
                print(S_effct)
                if S_effct != "0" && S_effct != "0.0"{
                    SLvArray.append("SLv"+"\(i)")
                }
            }
        }
        
        for i in 1..<100{
            plusArray.append("+"+"\(i)")
        }
        
        
    }

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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        initCollectionView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PickerViewArrayShape()
        PickerViewSetting()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    @IBAction func OKButtonTouchUpInside(_ sender: Any) {
        let contentVC = WeaponSelectViewController()
        let _ = contentVC.view
        
        if LvTextField.text?.isEmpty == false{
            Lv = LvTextField.text ?? "3凸(100Lv)"
        }else{
            Lv = "3凸(100Lv)"
        }
        if SLvTextField.text?.isEmpty == false{
            SLv = SLvTextField.text ?? "SLv10"
        }else{
            SLv = "SLv10"
        }
        if plusTextField.text?.isEmpty == false{
            plus = CulcFunctions.plusShaped(plus: plusTextField.text ?? "+0")
        }else{
            plus = 0
        }
        
        print(SLv)
        
        maxLv = 100
        
        atk = CulcFunctions.ATKCulc(minatk: Double(minatk)!, maxatk1: Double(maxatk1)!,maxatk2: Double(maxatk2)!,maxatk3: Double(maxatk3)!, Lv: Lv, maxLv: maxLv, plus: plus)
        hp = CulcFunctions.HPCulc(minhp: Double(minhp)!, maxhp1: Double(maxhp1)!,maxhp2: Double(maxhp2)!,maxhp3: Double(maxhp3)!, Lv: Lv, maxLv: maxLv, plus: plus)
        
        f_skill_element = CulcFunctions.SkillElement(skill_detail: f_skill_detail1, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        s_skill_element = CulcFunctions.SkillElement(skill_detail: s_skill_detail1, pre_skill_detail: pre_s_skill_detail1, Lv:Lv)
        
        f_skill = CulcFunctions.CheckSkill(skill_detail: f_skill_detail1, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        s_skill = CulcFunctions.CheckSkill(skill_detail: s_skill_detail1, pre_skill_detail: pre_s_skill_detail1, Lv:Lv)
        
        SLv = CulcFunctions.SLvShaped(SLv: SLv)
        
        print(f_skill_detail1)
        f_skill_amount1 = CulcFunctions.returnSkillEffectAmount(skill_detail: f_skill_detail1, SLv: Int(SLv)!, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        f_skill_amount2 = CulcFunctions.returnSkillEffectAmount(skill_detail: f_skill_detail2, SLv: Int(SLv)!, pre_skill_detail: pre_f_skill_detail2, Lv:Lv)
        s_skill_amount1 = CulcFunctions.returnSkillEffectAmount(skill_detail: s_skill_detail1, SLv: Int(SLv)!, pre_skill_detail: pre_s_skill_detail1, Lv:Lv)
        s_skill_amount2 = CulcFunctions.returnSkillEffectAmount(skill_detail: s_skill_detail2, SLv: Int(SLv)!, pre_skill_detail: pre_f_skill_detail2, Lv:Lv)
        
        contentVC.name = String(name)
        contentVC.attribute = String(attribute)
        contentVC.Lv = String(Lv)
        contentVC.atk = String(atk)
        contentVC.hp = String(hp)
        contentVC.SLv = String(SLv)
        contentVC.f_skill = String(f_skill)
        contentVC.s_skill = String(s_skill)
        contentVC.f_skill_element = String(f_skill_element)
        contentVC.s_skill_element = String(s_skill_element)
        contentVC.f_skill_amount1 = String(f_skill_amount1)
        contentVC.s_skill_amount1 = String(s_skill_amount1)
        contentVC.f_skill_amount2 = String(f_skill_amount2)
        contentVC.s_skill_amount2 = String(s_skill_amount2)
        contentVC.species = String(species)
        
        print(f_skill_amount1)
        print(s_skill_amount1)
        /*
         contentVC.species = species
         contentVC.rank = rank
         contentVC.f_skill = f_skill
         contentVC.s_skill = s_skill
         contentVC.minhp = minhp
         contentVC.minatk = minatk
         contentVC.maxhp1 = maxhp1
         contentVC.maxatk1 = maxatk1
         contentVC.f_skill_effect = f_skill_effect
         contentVC.s_skill_effect = s_skill_effect
         contentVC.f_skill_detail1 = f_skill_detail1
         contentVC.s_skill_detail1 = s_skill_detail1
         contentVC.f_skill_detail2 = f_skill_detail2
         contentVC.s_skill_detail2 = s_skill_detail2
         contentVC.pre_f_skill_effect = pre_f_skill_effect
         contentVC.pre_s_skill_effect = pre_s_skill_effect
         contentVC.pre_f_skill_detail1 = pre_f_skill_detail1
         contentVC.pre_s_skill_detail1 = pre_s_skill_detail1
         contentVC.pre_f_skill_detail2 = pre_f_skill_detail2
         contentVC.pre_s_skill_detail2 = pre_s_skill_detail2
         */
        
        NotificationCenter.default.post(name: .saveWeaponName, object: self)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //contentVC.didChangeTextField()
        //contentVC.NameTextField.text = name
        //print(contentVC.NameTextField.text!)
        //self.performSegue(withIdentifier: "WeaponPoped", sender: nil)
        //contentVC.Present2()
        //contentVC.popoverPresentationControllerDidDismissPopover(popoverPresentationController!)
        //popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover?(popoverPresentationController!)
    }
    
    
    //PickerView
    func PickerViewSetting(){
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([flexibleItem, flexibleItem, doneItem], animated: true)
        toolbar.sizeToFit()
        
        self.LvTextField.inputView = pickerView1
        self.LvTextField.inputAccessoryView = toolbar
        
        self.SLvTextField.inputView = pickerView2
        self.SLvTextField.inputAccessoryView = toolbar
        
        self.plusTextField.inputView = pickerView3
        self.plusTextField.inputAccessoryView = toolbar
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return LvArray.count
        }else if pickerView.tag == 2{
            return SLvArray.count
        }else{
            return plusArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return LvArray[row]
        }else if pickerView.tag == 2{
            return SLvArray[row]
        }else{
            return plusArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            self.LvTextField.text = LvArray[row]
        }else if pickerView.tag == 2{
            self.SLvTextField.text = SLvArray[row]
        }else{
            self.plusTextField.text = plusArray[row]
        }
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func initCollectionView(){
        self.collectionView.register(UINib(nibName: "WeaponNumberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeaponNumber")
        
    }
    
    //Cell Number
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberArray.count
    }
    
    //Cell Content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeaponNumber", for: indexPath as IndexPath) as! WeaponNumberCollectionViewCell
        
        cell.NumberLabel.text = NumberArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        WeaponNumber = indexPath.row + 1
        let contentVC = WeaponSelectViewController()
        let _ = contentVC.view
        
        if LvTextField.text?.isEmpty == false{
            Lv = LvTextField.text ?? "3凸(100Lv)"
        }else{
            Lv = "3凸(100Lv)"
        }
        if SLvTextField.text?.isEmpty == false{
            SLv = SLvTextField.text ?? "SLv10"
        }else{
            SLv = "SLv10"
        }
        if plusTextField.text?.isEmpty == false{
            plus = CulcFunctions.plusShaped(plus: plusTextField.text ?? "+0")
        }else{
            plus = 0
        }
        
        print(SLv)
        
        maxLv = 100
        
        atk = CulcFunctions.ATKCulc(minatk: Double(minatk)!, maxatk1: Double(maxatk1)!,maxatk2: Double(maxatk2)!,maxatk3: Double(maxatk3)!, Lv: Lv, maxLv: maxLv, plus: plus)
        hp = CulcFunctions.HPCulc(minhp: Double(minhp)!, maxhp1: Double(maxhp1)!,maxhp2: Double(maxhp2)!,maxhp3: Double(maxhp3)!, Lv: Lv, maxLv: maxLv, plus: plus)
        
        f_skill_element = CulcFunctions.SkillElement(skill_detail: f_skill_detail1, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        s_skill_element = CulcFunctions.SkillElement(skill_detail: s_skill_detail1, pre_skill_detail: pre_s_skill_detail1, Lv:Lv)
        
        f_skill = CulcFunctions.CheckSkill(skill_detail: f_skill_detail1, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        s_skill = CulcFunctions.CheckSkill(skill_detail: s_skill_detail1, pre_skill_detail: pre_s_skill_detail1, Lv:Lv)
        
        SLv = CulcFunctions.SLvShaped(SLv: SLv)
        
        print(f_skill_detail1)
        f_skill_amount1 = CulcFunctions.returnSkillEffectAmount(skill_detail: f_skill_detail1, SLv: Int(SLv)!, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        f_skill_amount2 = CulcFunctions.returnSkillEffectAmount(skill_detail: f_skill_detail2, SLv: Int(SLv)!, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        s_skill_amount1 = CulcFunctions.returnSkillEffectAmount(skill_detail: s_skill_detail1, SLv: Int(SLv)!, pre_skill_detail: pre_s_skill_detail1, Lv:Lv)
        s_skill_amount2 = CulcFunctions.returnSkillEffectAmount(skill_detail: s_skill_detail2, SLv: Int(SLv)!, pre_skill_detail: pre_f_skill_detail1, Lv:Lv)
        
        contentVC.name = String(name)
        contentVC.attribute = String(attribute)
        contentVC.Lv = String(Lv)
        contentVC.atk = String(atk)
        contentVC.hp = String(hp)
        contentVC.SLv = String(SLv)
        contentVC.f_skill = String(f_skill)
        contentVC.s_skill = String(s_skill)
        contentVC.f_skill_element = String(f_skill_element)
        contentVC.s_skill_element = String(s_skill_element)
        contentVC.f_skill_amount1 = String(f_skill_amount1)
        contentVC.s_skill_amount1 = String(s_skill_amount1)
        contentVC.f_skill_amount2 = String(f_skill_amount2)
        contentVC.s_skill_amount2 = String(s_skill_amount2)
        contentVC.species = String(species)
        
        print(f_skill_amount1)
        print(s_skill_amount1)
        /*
         contentVC.species = species
         contentVC.rank = rank
         contentVC.f_skill = f_skill
         contentVC.s_skill = s_skill
         contentVC.minhp = minhp
         contentVC.minatk = minatk
         contentVC.maxhp1 = maxhp1
         contentVC.maxatk1 = maxatk1
         contentVC.f_skill_effect = f_skill_effect
         contentVC.s_skill_effect = s_skill_effect
         contentVC.f_skill_detail1 = f_skill_detail1
         contentVC.s_skill_detail1 = s_skill_detail1
         contentVC.f_skill_detail2 = f_skill_detail2
         contentVC.s_skill_detail2 = s_skill_detail2
         contentVC.pre_f_skill_effect = pre_f_skill_effect
         contentVC.pre_s_skill_effect = pre_s_skill_effect
         contentVC.pre_f_skill_detail1 = pre_f_skill_detail1
         contentVC.pre_s_skill_detail1 = pre_s_skill_detail1
         contentVC.pre_f_skill_detail2 = pre_f_skill_detail2
         contentVC.pre_s_skill_detail2 = pre_s_skill_detail2
         */
        
        NotificationCenter.default.post(name: .saveWeaponName, object: self)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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

/*
extension WeaponSelectPopUpViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 一度計算したらキャッシュし、負荷を軽減
        // TODO: landscape表示に対応している場合は再計算を行うこと
        if let cellSize = self.computedCellSize {
            return cellSize
        } else {
            // PropotionalSizingCell.nibから原型セルを生成し、2列表示に適切なサイズを求める
            guard
                let prototypeCell = WeaponNumberCollectionViewCell.nib.instantiate(withOwner: nil, options: nil).first as? WeaponNumberCollectionViewCell,
                let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
                else {
                    fatalError()
            }
            
            let cellSize = prototypeCell.propotionalScaledSize(for: flowLayout, numberOfColumns: 5)
            self.computedCellSize = cellSize
            
            return cellSize
        }
    }
}

private extension WeaponNumberCollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
*/
