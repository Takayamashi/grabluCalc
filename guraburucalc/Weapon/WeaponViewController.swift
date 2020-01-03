//
//  ViewController.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/03.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class WeaponViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    var bannerView: GADBannerView!
    
    
    let elementArray = ["火", "水", "土", "風", "闇", "光"]
    let SkillArray:[String] = SkillPickerArray().returnSkillArray()
    var userDefaults = UserDefaults.standard
    var WeaponCells:[[String]] = [[String]]()
    var SelectedWeaponCells:[[String]] = [[String]]()
    var observer: NSObjectProtocol?
    let CulcFunctions = WeaponCulc()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBar.delegate = self
        initTableView()
        setTabBar()
        if self.userDefaults.object(forKey: "WeaponCell") != nil{
            self.WeaponCells = self.userDefaults.array(forKey: "WeaponCell") as! [[String]]
        }else{
            self.WeaponCells = [[String]]()
        }
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //AdMob
        // In this case, we instantiate the banner with desired ad size.
        let adSize = GADAdSizeFromCGSize(CGSize(width: 200, height: 40))
        bannerView = GADBannerView(adSize: adSize)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3655559129170405/9066685436"
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
        if self.userDefaults.object(forKey: "WeaponCell") != nil{
            self.WeaponCells = self.userDefaults.array(forKey: "WeaponCell") as! [[String]]
        }else{
            self.WeaponCells = [[String]]()
        }
        observer = NotificationCenter.default.addObserver(forName: .reloadData, object: nil, queue: OperationQueue.main){(notification) in
            let WeaponSelectVC = notification.object as! WeaponSelectViewController
            self.WeaponCells = WeaponSelectVC.WeaponCells
            self.tableView.reloadData()
            print(self.WeaponCells)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setTabBar(){
        tabBar.selectedItem = tabBar.items![0]
    }
    
    func initTableView(){
        self.tableView.register(UINib(nibName: "WeaponCell", bundle: nil), forCellReuseIdentifier: "WeaponCustomCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeaponCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeaponCustomCell", for: indexPath) as! WeaponCell
        
        if WeaponCells.isEmpty == false{
            cell.Name.text = WeaponCells[indexPath.row][0]
            cell.Lv.text = CulcFunctions.LvShaped(Lv: WeaponCells[indexPath.row][2])
            cell.SLv.text = "SLv"+WeaponCells[indexPath.row][3]
            cell.f_skill.text = WeaponCells[indexPath.row][8]
            cell.s_skill.text = WeaponCells[indexPath.row][9]
            
            if WeaponCells[indexPath.row][14] == "false"{
                cell.checkButton.setImage(UIImage(named:"nocheck")!, for: .normal)
            }else{
                cell.checkButton.setImage(UIImage(named:"checked")!, for: .normal)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 以下を追加してください。
        tableView.deselectRow(at: indexPath, animated: true)
        if WeaponCells[indexPath.row][14] == "false"{
            WeaponCells[indexPath.row][14] = "true"
        }else{
            WeaponCells[indexPath.row][14] = "false"
        }
        userDefaults.set(WeaponCells, forKey: "WeaponCell")
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        WeaponCells.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        userDefaults.set(WeaponCells, forKey: "WeaponCell")
    }
    
    @IBAction func deleteButtonTouchUpInside(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "武器データを全て削除します", message: "", preferredStyle:  UIAlertController.Style.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            self.WeaponCells = [[String]]()
            self.userDefaults.set(self.WeaponCells, forKey: "WeaponCell")
            self.tableView.reloadData()
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        
        case 1:
            //home画面に更新
            userDefaults.set(WeaponCells, forKey: "WeaponCell")
            tableView.reloadData()
            
        case 2:
            //WebViewのstoryboard指定
            userDefaults.set(WeaponCells, forKey: "WeaponCell")
            let storyboard: UIStoryboard = UIStoryboard(name: "Samon", bundle: nil)
            let SamonVC = storyboard.instantiateViewController(withIdentifier: "Samon") as! SamonViewController
            //self.show(WebViewVC, sender: nil)
            //self.present(WebViewVC, animated: false, completion: nil)
            let navigationController = UINavigationController(rootViewController: SamonVC)
            self.present(navigationController, animated: false, completion: nil)
            
            
        case 3:
            //行きたい画面に遷移
            userDefaults.set(WeaponCells, forKey: "WeaponCell")
            let storyboard: UIStoryboard = UIStoryboard(name: "Culc", bundle: nil)
            let CulcVC = storyboard.instantiateViewController(withIdentifier: "Culc") as! CulcViewController
            //self.show(WebViewVC, sender: nil)
            //self.present(WebViewVC, animated: false, completion: nil)
            let navigationController = UINavigationController(rootViewController: CulcVC)
            self.present(navigationController, animated: false, completion: nil)
            
            
        default:
            return
        }
        
    }

}

