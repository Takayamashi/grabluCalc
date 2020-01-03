//
//  CulcViewController.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/16.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CulcViewController: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    var userDefaults = UserDefaults.standard
    var Player = [String]()
    var WeaponCells:[[String]] = [[String]]()
    let CulcFunctions = WeaponCulc()
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var elementTextField: UITextField!
    @IBOutlet weak var elementButton: UIButton!
    @IBOutlet weak var ContentLabel: UILabel!
    
    var pickerView: UIPickerView = UIPickerView()
    
    let ATKCells:[String] = ["攻刃", "背水", "M攻刃", "M背水", "EX攻刃", "EX背水", "渾身", "M渾身", "技巧", "技巧", "", ""]
    var ATKContents:[Double] = [Double]()
    let ATKAmountCells:[String] = ["通常", "有利", "不利"]
    var ATKAmountContents:[Double] = [Double]()
    let HPCells:[String] = ["守護", "M守護", "EX守護", "バハHP", "DA", "MDA", "EXDA", "", "TA", "MTA", "EXTA", ""]
    var HPContents:[Double] = [Double]()
    let HPAmountCells:[String] = ["表示", "推定"]
    var HPAmountContents:[Double] = [Double]()
    
    var Cells:[String] = [String]()
    var Contents:[Double] = [Double]()
    var AmountCells:[String] = [String]()
    var AmountContents:[Double] = [Double]()
    
    var computedCellSize: CGSize?
    var element:String = "火"
    let elementArray = ["火", "水", "土", "風", "闇", "光"]
    
    var bannerView: GADBannerView!
    

    override func viewDidLoad() {
        if self.userDefaults.object(forKey: "WeaponCell") != nil{
            self.WeaponCells = self.userDefaults.array(forKey: "WeaponCell") as! [[String]]
        }else{
            self.WeaponCells = [[String]]()
        }
        
        if self.userDefaults.object(forKey: "Player") != nil{
            self.Player = self.userDefaults.array(forKey: "Player") as! [String]
            print(Player)
        }else{
            self.Player = [String]()
        }
        
        super.viewDidLoad()
        self.tabBar.delegate = self
        setTabBar()
        collectionView1.tag = 1
        collectionView2.tag = 2
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        initCollectionView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        PickerViewSetting()
        elementTextField.text = element
        
        if WeaponCells.isEmpty == false{
            if Player.isEmpty == false{
                print(Player)
                ATKContents = CulcFunctions.CulcATK(WeaponCells: WeaponCells, Player: Player, element: element)
                ATKAmountContents = CulcFunctions.CulcATKAmount(WeaponCells: WeaponCells, Player: Player, element: element)
                print(ATKContents)
                HPContents = CulcFunctions.CulcHP(WeaponCells: WeaponCells, Player: Player, element: element)
                HPAmountContents = CulcFunctions.CulcHPAmount(WeaponCells: WeaponCells, Player: Player, element: element)
            }
        }
        
        Cells = ATKCells
        Contents = ATKContents
        AmountCells = ATKAmountCells
        AmountContents = ATKAmountContents
        // Do any additional setup after loading the view.
        
        
        // In this case, we instantiate the banner with desired ad size.
        let adSize = GADAdSizeFromCGSize(CGSize(width: 200, height: 40))
        bannerView = GADBannerView(adSize: adSize)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3655559129170405/3665775827"
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
    
    @IBAction func ATKButtonTouchUpInside(_ sender: Any) {
        
        if WeaponCells.isEmpty == false{
            if Player.isEmpty == false{
                Cells = ATKCells
                Contents = ATKContents
                AmountCells = ATKAmountCells
                AmountContents = ATKAmountContents
                collectionView1.reloadData()
                collectionView2.reloadData()
                print(WeaponCells)
                ContentLabel.text = "総合攻撃力"
            }
        }
    }
    
    @IBAction func HPButtonTouchUpInside(_ sender: Any) {
        if WeaponCells.isEmpty == false{
            if Player.isEmpty == false{
                Cells = HPCells
                Contents = HPContents
                AmountCells = HPAmountCells
                AmountContents = HPAmountContents
                collectionView1.reloadData()
                collectionView2.reloadData()
                ContentLabel.text = "総合HP"
            }
        }
    }
    
    
    private func initCollectionView() {
        self.collectionView1.register(UINib(nibName: "CulcATKCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CulcATK")
        self.collectionView2.register(UINib(nibName: "CulcATKAmountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CulcATKAmount")
    }
    
    //Cell Number
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return Cells.count
        }else{
            return AmountCells.count
        }
    }
    
    //Cell Content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CulcATK", for: indexPath as IndexPath) as! CulcATKCollectionViewCell
            cell.ATKLabel.text = Cells[indexPath.row]
            if WeaponCells.isEmpty == false{
                if Player.isEmpty == false{
                    cell.ATKAmountLabel.text = String(format:"%.1f", Contents[indexPath.row])
                }
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CulcATKAmount", for: indexPath as IndexPath) as! CulcATKAmountCollectionViewCell
            cell.ATKLabel.text = AmountCells[indexPath.row]
            
            if WeaponCells.isEmpty == false{
                if Player.isEmpty == false{
                    cell.ATKAmountLabel.text = String(Int(AmountContents[indexPath.row]))
                }
            }
            
            cell.ATKLabel.adjustsFontSizeToFitWidth = true
            cell.ATKAmountLabel.adjustsFontSizeToFitWidth = true

            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func setTabBar(){
        tabBar.selectedItem = tabBar.items![2]
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
        
        self.elementTextField.inputView = pickerView
        self.elementTextField.inputAccessoryView = toolbar
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
        self.elementTextField.text = elementArray[row]
    }
    
    @objc func cancel() {
        self.elementTextField.text = "火"
        self.elementTextField.endEditing(true)
    }
    
    @objc func done() {
        element = elementTextField.text!
        self.elementTextField.endEditing(true)
        if WeaponCells.isEmpty == false{
            if Player.isEmpty == false{
                print(Player)
                ATKContents = CulcFunctions.CulcATK(WeaponCells: WeaponCells, Player: Player, element: element)
                ATKAmountContents = CulcFunctions.CulcATKAmount(WeaponCells: WeaponCells, Player: Player, element: element)
                print(ATKContents)
                HPContents = CulcFunctions.CulcHP(WeaponCells: WeaponCells, Player: Player, element: element)
                HPAmountContents = CulcFunctions.CulcHPAmount(WeaponCells: WeaponCells, Player: Player, element: element)
            }
        }
        
        if element == "火"{
            elementButton.setImage(UIImage(named:"fire")!, for: .normal)
        }else if element == "水"{
            elementButton.setImage(UIImage(named:"water")!, for: .normal)
        }else if element == "土"{
            elementButton.setImage(UIImage(named:"soil")!, for: .normal)
        }else if element == "風"{
            elementButton.setImage(UIImage(named:"wind")!, for: .normal)
        }else if element == "闇"{
            elementButton.setImage(UIImage(named:"dark")!, for: .normal)
        }else if element == "光"{
            elementButton.setImage(UIImage(named:"light")!, for: .normal)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            //home画面に更新
            let storyboard: UIStoryboard = UIStoryboard(name: "Weapon", bundle: nil)
            let WeaponVC = storyboard.instantiateViewController(withIdentifier: "Weapon") as! WeaponViewController
            //self.show(WebViewVC, sender: nil)
            //self.present(WebViewVC, animated: false, completion: nil)
            let navigationController = UINavigationController(rootViewController: WeaponVC)
            self.present(navigationController, animated: false, completion: nil)
            
        case 2:
            //WebViewのstoryboard指定
            let storyboard: UIStoryboard = UIStoryboard(name: "Samon", bundle: nil)
            let SamonVC = storyboard.instantiateViewController(withIdentifier: "Samon") as! SamonViewController
            //self.show(WebViewVC, sender: nil)
            //self.present(WebViewVC, animated: false, completion: nil)
            let navigationController = UINavigationController(rootViewController: SamonVC)
            self.present(navigationController, animated: false, completion: nil)
            
            
        case 3:
            //行きたい画面に遷移
            print("2")
            
            
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


extension CulcViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 一度計算したらキャッシュし、負荷を軽減
        // TODO: landscape表示に対応している場合は再計算を行うこと
        /*
        if let cellSize = self.computedCellSize {
            return cellSize
        } else {
 
        // PropotionalSizingCell.nibから原型セルを生成し、2列表示に適切なサイズを求める
        
        
        guard
            let prototypeCell1 = CulcATKCollectionViewCell.nib.instantiate(withOwner: nil, options: nil).first as? CulcATKCollectionViewCell,
            let flowLayout1 = collectionViewLayout as? UICollectionViewFlowLayout,
            let prototypeCell2 = CulcATKAmountCollectionViewCell.nib.instantiate(withOwner: nil, options: nil).first as? CulcATKAmountCollectionViewCell,
            let flowLayout2 = collectionViewLayout as? UICollectionViewFlowLayout
            else {
                fatalError()
        }
        
        let cellSize1 = prototypeCell1.propotionalScaledSize(for: flowLayout1, numberOfColumns: 4)
        let cellSize2 = prototypeCell2.propotionalScaledSize(for: flowLayout2, numberOfColumns: 1)
        */
        
        if collectionView.tag == 1{
            /*
            self.computedCellSize = cellSize1
            return cellSize1
            */
            //　横幅を画面サイズの約半分にする
            let cellSize_width:CGFloat = self.collectionView1.bounds.width/4
            let cellSize_height:CGFloat = self.collectionView1.bounds.height/3
            return CGSize(width: cellSize_width, height: cellSize_height)
        }else{
            let cellSize_width:CGFloat = self.collectionView2.bounds.width
            let cellSize_height:CGFloat = self.collectionView2.bounds.height/3
            return CGSize(width: cellSize_width, height: cellSize_height)
        }
    }
}

private extension CulcATKCollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

private extension CulcATKAmountCollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
