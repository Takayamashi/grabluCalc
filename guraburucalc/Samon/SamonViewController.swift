//
//  SamonViewController.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/16.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SamonViewController: UIViewController, UITabBarDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var userDefaults = UserDefaults.standard
    var Player = [String]()
    var bannerView: GADBannerView!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var rankTextField: UITextField!
    @IBOutlet weak var favorite1TextField: UITextField!
    @IBOutlet weak var favorite2TextField: UITextField!
    @IBOutlet weak var HPpercentTextField: UITextField!
    @IBOutlet weak var bonusATKTextField: UITextField!
    @IBOutlet weak var bonusHPTextField: UITextField!
    @IBOutlet weak var SamonATKTextField: UITextField!
    @IBOutlet weak var SamonHPTextField: UITextField!
    @IBOutlet weak var SamonEffect1TextField: UITextField!
    @IBOutlet weak var SamonEffect2TextField: UITextField!
    @IBOutlet weak var SamonAmount1TextField: UITextField!
    @IBOutlet weak var SamonAmount2TextField: UITextField!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var hppercentLabel: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var samonLabel: UILabel!
    @IBOutlet weak var bonusATKLabel: UILabel!
    @IBOutlet weak var bonusHPLabel: UILabel!
    @IBOutlet weak var samonATKLabel: UILabel!
    @IBOutlet weak var samonHPLabel: UILabel!
    
    
    
    
    var pickerView1: UIPickerView = UIPickerView()
    var pickerView2: UIPickerView = UIPickerView()
    var pickerView3: UIPickerView = UIPickerView()
    var pickerView4: UIPickerView = UIPickerView()
    var pickerView5: UIPickerView = UIPickerView()
    var textFieldtag:Int = 0
    let FavoriteWeapons: [String] = ["剣", "槍", "斧", "弓", "杖", "短剣", "格闘", "銃", "刀", "楽器"]
    let HPPercents:[String] = ["100%", "75%", "50%", "25%", "1%"]
    let SamonEffects:[String] = ["属性", "神石", "マグナ"]
    var rank = "0"
    var favorite1 = "0"
    var favorite2 = "0"
    var HPPercent = "0"
    var bonusATK = "0"
    var bonusHP = "0"
    var SamonATK = "0"
    var SamonHP = "0"
    var SamonEffect1 = "0"
    var SamonEffect2 = "0"
    var SamonAmount1 = "0"
    var SamonAmount2 = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankLabel.adjustsFontSizeToFitWidth = true
        favoriteLabel.adjustsFontSizeToFitWidth = true
        hppercentLabel.adjustsFontSizeToFitWidth = true
        bonusLabel.adjustsFontSizeToFitWidth = true
        samonLabel.adjustsFontSizeToFitWidth = true
        bonusATKLabel.adjustsFontSizeToFitWidth = true
        bonusHPLabel.adjustsFontSizeToFitWidth = true
        samonATKLabel.adjustsFontSizeToFitWidth = true
        samonHPLabel.adjustsFontSizeToFitWidth = true
        
        self.tabBar.delegate = self
        setTabBar()
        PickerViewSetting()
        self.rankTextField.delegate = self
        self.favorite1TextField.delegate = self
        self.favorite2TextField.delegate = self
        self.HPpercentTextField.delegate = self
        self.bonusATKTextField.delegate = self
        self.bonusHPTextField.delegate = self
        self.SamonATKTextField.delegate = self
        self.SamonHPTextField.delegate = self
        self.SamonEffect1TextField.delegate = self
        self.SamonEffect2TextField.delegate = self
        
        self.rankTextField.tag = 0
        self.favorite1TextField.tag = 1
        self.favorite2TextField.tag = 2
        self.HPpercentTextField.tag = 3
        self.bonusATKTextField.tag = 4
        self.bonusHPTextField.tag = 5
        self.SamonATKTextField.tag = 6
        self.SamonHPTextField.tag = 7
        self.SamonEffect1TextField.tag = 8
        self.SamonEffect2TextField.tag = 9
        self.SamonAmount1TextField.tag = 10
        self.SamonAmount2TextField.tag = 11
        
        TextFieldRound(textField: rankTextField)
        TextFieldRound(textField: favorite1TextField)
        TextFieldRound(textField: favorite2TextField)
        TextFieldRound(textField: HPpercentTextField)
        TextFieldRound(textField: bonusATKTextField)
        TextFieldRound(textField: bonusHPTextField)
        TextFieldRound(textField: SamonATKTextField)
        TextFieldRound(textField: SamonHPTextField)
        TextFieldRound(textField: SamonEffect1TextField)
        TextFieldRound(textField: SamonEffect2TextField)
        TextFieldRound(textField: SamonAmount1TextField)
        TextFieldRound(textField: SamonAmount2TextField)
        
        rankTextField.keyboardType = UIKeyboardType.numberPad
        bonusATKTextField.keyboardType = UIKeyboardType.numberPad
        bonusHPTextField.keyboardType = UIKeyboardType.numberPad
        SamonATKTextField.keyboardType = UIKeyboardType.numberPad
        SamonHPTextField.keyboardType = UIKeyboardType.numberPad
        SamonAmount1TextField.keyboardType = UIKeyboardType.numberPad
        SamonAmount2TextField.keyboardType = UIKeyboardType.numberPad
        
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
        
        // Do any additional setup after loading the view.
        
        //AdMob
        // In this case, we instantiate the banner with desired ad size.
        let adSize = GADAdSizeFromCGSize(CGSize(width: 300, height: 50))
        bannerView = GADBannerView(adSize: adSize)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3655559129170405/1383281313"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: tabBar,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.userDefaults.object(forKey: "Player") != nil{
            self.Player = self.userDefaults.array(forKey: "Player") as! [String]
            
            rankTextField.text = Player[0]
            favorite1TextField.text = Player[1]
            favorite2TextField.text = Player[2]
            HPpercentTextField.text = Player[3]
            bonusATKTextField.text = Player[4]
            bonusHPTextField.text = Player[5]
            SamonATKTextField.text = Player[6]
            SamonHPTextField.text = Player[7]
            SamonEffect1TextField.text = Player[8]
            SamonEffect2TextField.text = Player[9]
            SamonAmount1TextField.text = Player[10]
            SamonAmount2TextField.text = Player[11]
        }else{
            self.Player = [String]()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setPlayertoUserDefaults()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setPlayertoUserDefaults()
    }
    
    func setPlayertoUserDefaults(){
        rank = rankTextField.text ?? "1"
        favorite1 = favorite1TextField.text ?? "0"
        favorite2 = favorite2TextField.text ?? "0"
        HPPercent = HPpercentTextField.text ?? "0"
        bonusATK = bonusATKTextField.text ?? "0"
        bonusHP = bonusHPTextField.text ?? "0"
        SamonATK = SamonATKTextField.text ?? "0"
        SamonHP = SamonHPTextField.text ?? "0"
        SamonEffect1 = SamonEffect1TextField.text ?? "0"
        SamonEffect2 = SamonEffect2TextField.text ?? "0"
        SamonAmount1 = SamonAmount1TextField.text ?? "0"
        SamonAmount2 = SamonAmount2TextField.text ?? "0"
        
        
        Player = [rank, favorite1, favorite2, HPPercent, bonusATK, bonusHP, SamonATK, SamonHP, SamonEffect1, SamonEffect2, SamonAmount1, SamonAmount2]
        
        userDefaults.set(Player, forKey: "Player")
    }
    
    func TextFieldRound(textField: UITextField){
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor(red: 112.0 / 255.0, green: 112.0 / 255.0, blue: 112.0 / 255.0, alpha: 1).cgColor
        textField.layer.borderWidth  = 1.0
        textField.layer.masksToBounds = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldtag = textField.tag
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        
        self.favorite1TextField.inputView = pickerView1
        self.favorite1TextField.inputAccessoryView = toolbar
        self.favorite2TextField.inputView = pickerView2
        self.favorite2TextField.inputAccessoryView = toolbar
        self.HPpercentTextField.inputView = pickerView3
        self.HPpercentTextField.inputAccessoryView = toolbar
        self.SamonEffect1TextField.inputView = pickerView4
        self.SamonEffect1TextField.inputAccessoryView = toolbar
        self.SamonEffect2TextField.inputView = pickerView5
        self.SamonEffect2TextField.inputAccessoryView = toolbar
        self.rankTextField.inputAccessoryView = toolbar
        self.bonusATKTextField.inputAccessoryView = toolbar
        self.bonusHPTextField.inputAccessoryView = toolbar
        self.SamonATKTextField.inputAccessoryView = toolbar
        self.SamonHPTextField.inputAccessoryView = toolbar
        self.SamonAmount1TextField.inputAccessoryView = toolbar
        self.SamonAmount2TextField.inputAccessoryView = toolbar
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) || (pickerView.tag == 2){
            return FavoriteWeapons.count
        }else if pickerView.tag == 3{
            return HPPercents.count
        }else{
            return SamonEffects.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 || (pickerView.tag == 2){
            return FavoriteWeapons[row]
        }else if pickerView.tag == 3{
            return HPPercents[row]
        }else{
            return SamonEffects[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.favorite1TextField.text = FavoriteWeapons[row]
        }else if pickerView.tag == 2{
            self.favorite2TextField.text = FavoriteWeapons[row]
        }else if pickerView.tag == 3{
            self.HPpercentTextField.text = HPPercents[row]
        }else if pickerView.tag == 4{
            return self.SamonEffect1TextField.text = SamonEffects[row]
        }else{
            return self.SamonEffect2TextField.text = SamonEffects[row]
        }
    }
    
    @objc func cancel() {
        let targetTxtFld = self.view.viewWithTag(textFieldtag) as? UITextField
        targetTxtFld?.text = ""
        view.endEditing(true)
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    
    func setTabBar(){
        tabBar.selectedItem = tabBar.items![1]
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            setPlayertoUserDefaults()
            let storyboard: UIStoryboard = UIStoryboard(name: "Weapon", bundle: nil)
            let WeaponVC = storyboard.instantiateViewController(withIdentifier: "Weapon") as! WeaponViewController
            //self.show(WebViewVC, sender: nil)
            //self.present(WebViewVC, animated: false, completion: nil)
            let navigationController = UINavigationController(rootViewController: WeaponVC)
            self.present(navigationController, animated: false, completion: nil)
            
        case 2:
            //WebViewのstoryboard指定
            setPlayertoUserDefaults()
            print("2")
            
        case 3:
            setPlayertoUserDefaults()
            //行きたい画面に遷移
            let storyboard: UIStoryboard = UIStoryboard(name: "Culc", bundle: nil)
            let CulcVC = storyboard.instantiateViewController(withIdentifier: "Culc") as! CulcViewController
            let navigationController = UINavigationController(rootViewController: CulcVC)
            self.present(navigationController, animated: false, completion: nil)
            
        default:
            return
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
