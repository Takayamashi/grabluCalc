//
//   CulcFunctions.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/23.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import Foundation

class WeaponCulc{
    func ATKCulc(minatk:Double, maxatk1:Double,maxatk2:Double,maxatk3:Double, Lv:String, maxLv:Int, plus:Int) -> Int{
        var level: Int
        let diff: Double = (maxatk1 - minatk)/Double(maxLv)
        
        if Lv == "無凸(40Lv)"{
            level = 40
            let atk = minatk + diff*Double(level)
            return Int(atk)+5*plus
        }else if Lv == "1凸(60Lv)"{
            level = 60
            let atk = minatk + diff*Double(level)
            return Int(atk)+5*plus
        }else if Lv == "2凸(80Lv)"{
            level = 80
            let atk = minatk + diff*Double(level)
            return Int(atk)+5*plus
        }else if Lv == "4凸(150Lv)"{
            level = 150
            return Int(maxatk2)+5*plus
        }else if Lv == "5凸(200Lv)"{
            level = 200
            return Int(maxatk3)+5*plus
        }else{
            level = 100
            return Int(maxatk1)+5*plus
        }
    }
    
    func HPCulc(minhp:Double, maxhp1:Double,maxhp2:Double,maxhp3:Double, Lv:String, maxLv:Int, plus:Int) -> Int{
        var level: Int
        let diff: Double = (maxhp1 - minhp)/Double(maxLv)
        
        if Lv == "無凸(40Lv)"{
            level = 40
            let hp = minhp + diff*Double(level)
            return Int(hp)+1*plus
        }else if Lv == "1凸(60Lv)"{
            level = 60
            let hp = minhp + diff*Double(level)
            return Int(hp)+1*plus
        }else if Lv == "2凸(80Lv)"{
            level = 80
            let hp = minhp + diff*Double(level)
            return Int(hp)+1*plus
        }else if Lv == "4凸(150Lv)"{
            level = 150
            return Int(maxhp2)+1*plus
        }else if Lv == "5凸(200Lv)"{
            level = 200
            return Int(maxhp3)+1*plus
        }else{
            level = 100
            return Int(maxhp1)+1*plus
        }
    }
    
    func SkillElement(skill_detail:String, pre_skill_detail:String, Lv:String) -> String{
        if Lv == "4凸(150Lv)" || Lv == "5凸(200Lv)"{
            if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[0])
            }else{
                return "なし"
            }
        }else{
            if pre_skill_detail != "0"{
                if String(skill_detail.split(separator: ",")[0]) != String(pre_skill_detail.split(separator: ",")[0]){
                    return String(pre_skill_detail.split(separator: ",")[0])
                }else{
                    return String(skill_detail.split(separator: ",")[0])
                }
            }else if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[0])
            }else{
                return "なし"
            }
        }
    }
    
    func CheckSkill(skill_detail:String, pre_skill_detail:String, Lv:String) -> String{
        if Lv == "4凸(150Lv)" || Lv == "5凸(200Lv)"{
            if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[1])
            }else{
                return "なし"
            }
        }else{
            if pre_skill_detail != "0"{
                if String(skill_detail.split(separator: ",")[1]) != String(pre_skill_detail.split(separator: ",")[1]){
                    return String(pre_skill_detail.split(separator: ",")[1])
                }else{
                    return String(skill_detail.split(separator: ",")[1])
                }
            }else if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[1])
            }else{
                return "なし"
            }
        }
    }
    
    func CheckSkill_Changed(skill_detail:String) -> String{
        if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[1])
            }else{
                return "なし"
            }
    }
    
    func SLvShaped(SLv:String) -> String{
        return SLv.components(separatedBy: "SLv")[1]
    }
    
    
    func SkillEffect(skill_detail:String) -> String{
        return String(skill_detail.split(separator: ",")[1])
    }
    
    func returnSkillEffectAmount(skill_detail:String, SLv:Int, pre_skill_detail:String, Lv:String) -> String{
        if Lv == "4凸(150Lv)" || Lv == "5凸(200Lv)"{
            if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[SLv+1])
            }else{
                return "0"
            }
        }else{
            if pre_skill_detail != "0" && skill_detail != "0"{
                if String(skill_detail.split(separator: ",")[1]) != String(pre_skill_detail.split(separator: ",")[1]){
                    return String(pre_skill_detail.split(separator: ",")[SLv+1])
                }else{
                    return String(skill_detail.split(separator: ",")[SLv+1])
                }
            }else if skill_detail != "0"{
                return String(skill_detail.split(separator: ",")[SLv+1])
            }else{
                return "0"
            }
        }
        
        /*
        if skill_detail != "0"{
            return String(skill_detail.split(separator: ",")[SLv+1])
        }else{
            return "0"
        }
        */
    }
    
    func returnSkillEffectAmount_Changed(skill_detail:String, SLv:Int) -> String{
        if skill_detail != "0"{
            return String(skill_detail.split(separator: ",")[SLv+1])
        }else{
            return "0"
        }
    }
    
    
    func LvShaped(Lv:String) -> String{
        return Lv.components(separatedBy: "(")[0]
    }
    
    func plusShaped(plus:String) -> Int{
        return Int(plus.components(separatedBy: "+")[1]) ?? 0
    }
    
    
    func CulcATK(WeaponCells:[[String]], Player:[String], element:String) -> [Double]{
        var n_attack = 0.0
        var n_haisui = 0.0
        var m_attack = 0.0
        var m_haisui = 0.0
        var ex_attack = 0.0
        var ex_haisui = 0.0
        var n_konshin = 0.0
        var m_konshin = 0.0
        var n_critical = 0.0
        var m_critical = 0.0
        let HPpercent = Double(Player[3].components(separatedBy: "%")[0]) ?? 0.0
        let SamonEffect1 = Player[8]
        let SamonEffect2 = Player[9]
        let SamonAmount1 = Double(Player[10]) ?? 0.0
        let SamonAmount2 = Double(Player[11]) ?? 0.0
        
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][14] == "true"{
                if element == WeaponCells[i][6]{
                    if WeaponCells[i][8].contains("通常攻刃"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ攻刃"){
                        m_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("EX攻刃"){
                        ex_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常神威"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ神威"){
                        m_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常背水"){
                        n_haisui += culchaisui(HPPercent:HPpercent, haisui:Double(WeaponCells[i][10]) ?? 0.0)
                    }else if WeaponCells[i][8].contains("マグナ背水"){
                        m_haisui += culchaisui(HPPercent:HPpercent, haisui:Double(WeaponCells[i][10]) ?? 0.0)//Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常渾身"){
                        n_konshin += culckonshin(HPPercent: HPpercent, konshin: Double(WeaponCells[i][10]) ?? 0.0, skill: WeaponCells[i][8], SLv: WeaponCells[i][3])
                    }else if WeaponCells[i][8].contains("マグナ渾身"){
                        m_konshin += culckonshin(HPPercent: HPpercent, konshin: Double(WeaponCells[i][10]) ?? 0.0, skill: WeaponCells[i][8], SLv: WeaponCells[i][3])
                    }else if WeaponCells[i][8].contains("通常技巧"){
                        if n_critical<Double(WeaponCells[i][10]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][10]) ?? 0.0
                        }
                    }else if WeaponCells[i][8].contains("マグナ技巧"){
                        m_critical += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常暴君"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常暴君Ⅱ"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ暴君"){
                        m_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ暴君Ⅱ"){
                        m_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常無双"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常無双Ⅱ"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ無双"){
                        m_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常乱舞"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常刹那(小)"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                        if n_critical<Double(WeaponCells[i][11]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][11]) ?? 0.0
                        }
                    }else if WeaponCells[i][8].contains("通常刹那(中)"){
                        n_attack += Double(WeaponCells[i][10]) ?? 0.0
                        if n_critical<Double(WeaponCells[i][11]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][11]) ?? 0.0
                        }
                    }else if WeaponCells[i][8].contains("マグナ刹那(中)"){
                        m_attack += Double(WeaponCells[i][10]) ?? 0.0
                        m_critical += Double(WeaponCells[i][11]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常克己"){
                        if n_critical<Double(WeaponCells[i][11]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][11]) ?? 0.0
                        }
                    }
                    
                }
                if WeaponCells[i][7] == element{
                    if WeaponCells[i][9].contains("通常攻刃"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ攻刃"){
                        m_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("EX攻刃"){
                        ex_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常神威"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ神威"){
                        m_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常背水"){
                        n_haisui += culchaisui(HPPercent:HPpercent, haisui:Double(WeaponCells[i][12]) ?? 0.0)
                    }else if WeaponCells[i][9].contains("マグナ背水"){
                        m_haisui += culchaisui(HPPercent:HPpercent, haisui:Double(WeaponCells[i][12]) ?? 0.0)
                    }else if WeaponCells[i][9].contains("通常渾身"){
                        n_konshin += culckonshin(HPPercent: HPpercent, konshin: Double(WeaponCells[i][12]) ?? 0.0, skill: WeaponCells[i][9], SLv: WeaponCells[i][3]) //Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ渾身"){
                        m_konshin += culckonshin(HPPercent: HPpercent, konshin: Double(WeaponCells[i][12]) ?? 0.0, skill: WeaponCells[i][9], SLv: WeaponCells[i][3])
                    }else if WeaponCells[i][9].contains("通常技巧"){
                        if n_critical<Double(WeaponCells[i][12]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][12]) ?? 0.0
                        }
                    }else if WeaponCells[i][9].contains("マグナ技巧"){
                        m_critical += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常暴君"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常暴君Ⅱ"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ暴君"){
                        m_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ暴君Ⅱ"){
                        m_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常無双"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常無双Ⅱ"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ無双"){
                        m_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常乱舞"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常刹那(小)"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                        if n_critical<Double(WeaponCells[i][13]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][13]) ?? 0.0
                        }
                    }else if WeaponCells[i][9].contains("通常刹那(中)"){
                        n_attack += Double(WeaponCells[i][12]) ?? 0.0
                        if n_critical<Double(WeaponCells[i][13]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][13]) ?? 0.0
                        }
                    }else if WeaponCells[i][9].contains("マグナ刹那(中)"){
                        m_attack += Double(WeaponCells[i][12]) ?? 0.0
                        m_critical += Double(WeaponCells[i][13]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常克己"){
                        if n_critical<Double(WeaponCells[i][13]) ?? 0.0{
                            n_critical = Double(WeaponCells[i][13]) ?? 0.0
                        }
                    }
                }
                
            }
        }
        
        if SamonEffect1 == "神石" && SamonEffect2 == "神石"{
            n_attack = n_attack*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            n_haisui = n_haisui*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            n_konshin = n_konshin*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            n_critical = n_critical*(1.0+(SamonAmount1+SamonAmount2)/100.0)
        }else if SamonEffect1 == "マグナ" && SamonEffect2 == "マグナ"{
            m_attack = m_attack*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            m_haisui = m_haisui*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            m_konshin = m_konshin*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            m_critical = m_critical*(1.0+(SamonAmount1+SamonAmount2)/100.0)
        }else if SamonEffect1 == "神石"{
            n_attack = n_attack*(1.0+(SamonAmount1)/100.0)
            n_haisui = n_haisui*(1.0+(SamonAmount1)/100.0)
            n_konshin = n_konshin*(1.0+(SamonAmount1)/100.0)
            n_critical = n_critical*(1.0+(SamonAmount1)/100.0)
        }else if SamonEffect2 == "神石"{
            n_attack = n_attack*(1.0+(SamonAmount2)/100.0)
            n_haisui = n_haisui*(1.0+(SamonAmount2)/100.0)
            n_konshin = n_konshin*(1.0+(SamonAmount2)/100.0)
            n_critical = n_critical*(1.0+(SamonAmount2)/100.0)
        }else if SamonEffect1 == "マグナ"{
            m_attack = m_attack*(1.0+(SamonAmount1)/100.0)
            m_haisui = m_haisui*(1.0+(SamonAmount1)/100.0)
            m_konshin = m_konshin*(1.0+(SamonAmount1)/100.0)
            m_critical = m_critical*(1.0+(SamonAmount1)/100.0)
        }else if SamonEffect2 == "マグナ"{
            m_attack = m_attack*(1.0+(SamonAmount2)/100.0)
            m_haisui = m_haisui*(1.0+(SamonAmount2)/100.0)
            m_konshin = m_konshin*(1.0+(SamonAmount2)/100.0)
            m_critical = m_critical*(1.0+(SamonAmount2)/100.0)
        }
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][8].contains("バハ攻撃"){
                    n_attack += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("バハ攻撃/HP"){
                    n_attack += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("オメガ基礎"){
                    n_attack += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("オメガ闘争"){
                    n_attack += 20.0
                }
                
                if WeaponCells[i][9].contains("バハ攻撃"){
                    n_attack += Double(WeaponCells[i][12]) ?? 0.0
                }else if WeaponCells[i][9].contains("バハ攻撃/HP"){
                    n_attack += Double(WeaponCells[i][12]) ?? 0.0
                }else if WeaponCells[i][9].contains("オメガ基礎"){
                    n_attack += Double(WeaponCells[i][12]) ?? 0.0
                }
            }
        }
        
        
        
        return [n_attack, n_haisui, m_attack, m_haisui, ex_attack, ex_haisui, n_konshin, m_konshin, n_critical, m_critical, 0.0, 0.0]
    }
    
    func CulcATKAmount(WeaponCells:[[String]], Player:[String], element:String) -> [Double]{
        let rank = Double(Player[0]) ?? 1.0
        let favorite1 = Player[1]
        let favorite2 = Player[2]
        let bonusATK = Player[4]
        let samonATK = Player[6]
        let samoneffect1 = Player[8]
        let samoneffect2 = Player[9]
        let samonamount1 = Double(Player[10]) ?? 0.0
        let samonamount2 = Double(Player[11]) ?? 0.0
        var ATKCells = CulcATK(WeaponCells: WeaponCells, Player: Player, element: element)
        var atk:Double = 0.0
        var ad_atk:Double = 0.0
        var disad_atk:Double = 0.0
        var cosmosList = [String]()
        var weapon_atk = 0.0
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][8].contains("バハ攻撃"){
                    ATKCells[0] += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("バハ攻撃/HP"){
                    ATKCells[0] += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("オメガ基礎"){
                    ATKCells[0] += Double(WeaponCells[i][10]) ?? 0.0
                }
            }
            
            if WeaponCells[i][8].contains("コスモス"){
                if cosmosList.index(of:WeaponCells[i][1]) == nil{
                    cosmosList.append(WeaponCells[i][1])
                }
            }
        }
        
        if rank <= 100.0{
            atk += 1000.0 + (rank-1.0) * 40.0
        }else{
            atk += 4000.0 + (rank-100.0) * 20.0
        }
        
        
        
        for i in 0..<WeaponCells.count{
            weapon_atk = 0.0
            if WeaponCells[i][14] == "true"{
                weapon_atk = Double(WeaponCells[i][4]) ?? 0.0
                if cosmosList != []{
                    for j in 0..<cosmosList.count{
                        if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2 && WeaponCells[i][1]==cosmosList[j]{
                            atk += weapon_atk * 1.5
                        }else if WeaponCells[i][1]==cosmosList[j]{
                            atk += weapon_atk*1.3
                        }else if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2{
                            atk += weapon_atk*1.2
                        }else{
                            atk += weapon_atk
                        }
                    }
                }else{
                    if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2{
                        atk += weapon_atk*1.2
                    }else{
                        atk += weapon_atk
                    }
                }
            }
        }
            
            
        atk += Double(bonusATK) ?? 0.0
        atk += Double(samonATK) ?? 0.0
        
        
        atk = atk*(1+ATKCells[0]/100.0)*(1+ATKCells[1]/100.0)*(1+ATKCells[2]/100.0)*(1+ATKCells[3]/100.0)*(1+ATKCells[4]/100.0)*(1+ATKCells[5]/100.0)*(1+ATKCells[6]/100.0)*(1+ATKCells[7]/100.0)
        ad_atk = atk
        disad_atk = atk
        
        
        if samoneffect1 == "属性" && samoneffect2 == "属性"{
            atk = atk*(1+samonamount1/100.0 + samonamount2/100.0)
            ad_atk = atk*(1.5+samonamount1/100.0 + samonamount2/100.0)
            disad_atk = atk*(0.75+samonamount1/100.0 + samonamount2/100.0)
        }else if samoneffect1 == "属性"{
            atk = atk*(1+samonamount1/100.0)
            ad_atk = ad_atk*(1.5+samonamount1/100.0)
            disad_atk = disad_atk*(0.75+samonamount1/100.0)
        }else if samoneffect2 == "属性"{
            atk = atk*(1+samonamount2/100.0)
            ad_atk = ad_atk*(1.5+samonamount2/100.0)
            disad_atk = disad_atk*(0.75+samonamount2/100.0)
        }else{
            atk = atk*1.0
            ad_atk = ad_atk*1.5
            disad_atk = disad_atk*0.75
        }
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][8].contains("天司Ⅱ"){
                ad_atk = ad_atk*1.2
            }
        }
        
        
        return [atk, ad_atk, disad_atk]
    }
    
    func culckonshin(HPPercent:Double, konshin:Double, skill:String, SLv:String) -> Double{
        let skill_level = Double(SLv) ?? 10.0
        
        if HPPercent >= 25{
            if skill == "通常渾身(大)"{
                return pow(HPPercent/(56.4-skill_level), 2.9) + 2.1
            }else if skill == "通常渾身(中)"{
                return pow(HPPercent/(65.0-skill_level), 2.9) + 2.1
            }else if skill == "マグナ渾身(中)"{
                return pow(HPPercent/(60.4-skill_level), 2.9) + 2.1
            }else{
                return 0.0
            }
        }else{
            return 0.0
        }
    }
    
    func culchaisui(HPPercent:Double, haisui:Double) -> Double{
        let hp = 1.0 - HPPercent/100.0
        
        if HPPercent <= 75{
            return haisui*((1+2*hp)*hp)
        }else{
            return 0.0
        }
    }
    
    func CulcHP(WeaponCells:[[String]], Player:[String], element:String) -> [Double]{
        var n_def = 0.0
        var m_def = 0.0
        var ex_def = 0.0
        var bahaHP = 0.0
        var n_DA = 0.0
        var m_DA = 0.0
        var ex_DA = 0.0
        var n_TA = 0.0
        var m_TA = 0.0
        var ex_TA = 0.0
        let SamonEffect1 = Player[8]
        let SamonEffect2 = Player[9]
        let SamonAmount1 = Double(Player[10]) ?? 0.0
        let SamonAmount2 = Double(Player[11]) ?? 0.0
        
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][6] == element{
                    if WeaponCells[i][8].contains("通常守護"){
                        n_def += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ守護"){
                        m_def += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("EX守護"){
                        ex_def += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常神威"){
                        n_def += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ神威"){
                        m_def += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常二手"){
                        n_DA += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常三手"){
                        n_DA += Double(WeaponCells[i][10]) ?? 0.0
                        n_TA += Double(WeaponCells[i][10]) ?? 0.0//Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ二手"){
                        m_DA += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ三手"){
                        m_DA += Double(WeaponCells[i][10]) ?? 0.0
                        m_TA += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ破壊"){
                        m_TA += Double(WeaponCells[i][11]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常無双"){
                        n_DA += Double(WeaponCells[i][11]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常無双Ⅱ"){
                        n_DA += Double(WeaponCells[i][11]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ無双"){
                        n_DA += Double(WeaponCells[i][11]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常乱舞"){
                        n_TA += Double(WeaponCells[i][11]) ?? 0.0
                    }else if WeaponCells[i][8].contains("通常克己"){
                        n_TA += Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][8].contains("マグナ軍神"){
                        m_def += Double(WeaponCells[i][10]) ?? 0.0
                        m_DA += Double(WeaponCells[i][11]) ?? 0.0
                    }
                }
                
                if WeaponCells[i][7] == element{
                    if WeaponCells[i][9].contains("通常守護"){
                        n_def += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ守護"){
                        m_def += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("EX守護"){
                        ex_def += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常神威"){
                        n_def += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ神威"){
                        m_def += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常二手"){
                        n_DA += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常三手"){
                        n_DA += Double(WeaponCells[i][12]) ?? 0.0
                        n_TA += Double(WeaponCells[i][12]) ?? 0.0//Double(WeaponCells[i][10]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ二手"){
                        m_DA += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ三手"){
                        m_DA += Double(WeaponCells[i][12]) ?? 0.0
                        m_TA += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ破壊"){
                        m_TA += Double(WeaponCells[i][13]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常無双"){
                        n_DA += Double(WeaponCells[i][13]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常無双Ⅱ"){
                        n_DA += Double(WeaponCells[i][13]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ無双"){
                        n_DA += Double(WeaponCells[i][13]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常乱舞"){
                        n_TA += Double(WeaponCells[i][13]) ?? 0.0
                    }else if WeaponCells[i][9].contains("通常克己"){
                        n_TA += Double(WeaponCells[i][12]) ?? 0.0
                    }else if WeaponCells[i][9].contains("マグナ軍神"){
                        m_def += Double(WeaponCells[i][12]) ?? 0.0
                        m_DA += Double(WeaponCells[i][13]) ?? 0.0
                    }
                    
                }
                
            }
        }
        
        if SamonEffect1 == "神石" && SamonEffect2 == "神石"{
            n_def = n_def*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            n_DA = n_DA*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            n_TA = n_TA*(1.0+(SamonAmount1+SamonAmount2)/100.0)
        }else if SamonEffect1 == "マグナ" && SamonEffect2 == "マグナ"{
            m_def = m_def*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            m_DA = m_DA*(1.0+(SamonAmount1+SamonAmount2)/100.0)
            m_TA = m_TA*(1.0+(SamonAmount1+SamonAmount2)/100.0)
        }else if SamonEffect1 == "神石"{
            n_def = n_def*(1.0+(SamonAmount1)/100.0)
            n_DA = n_DA*(1.0+(SamonAmount1)/100.0)
            n_TA = n_TA*(1.0+(SamonAmount1)/100.0)
        }else if SamonEffect2 == "神石"{
            n_def = n_def*(1.0+(SamonAmount2)/100.0)
            n_DA = n_DA*(1.0+(SamonAmount2)/100.0)
            n_TA = n_TA*(1.0+(SamonAmount2)/100.0)
        }else if SamonEffect1 == "マグナ"{
            m_def = m_def*(1.0+(SamonAmount1)/100.0)
            m_DA = m_DA*(1.0+(SamonAmount1)/100.0)
            m_TA = m_TA*(1.0+(SamonAmount1)/100.0)
        }else if SamonEffect2 == "マグナ"{
            m_def = m_def*(1.0+(SamonAmount2)/100.0)
            m_DA = m_DA*(1.0+(SamonAmount2)/100.0)
            m_TA = m_TA*(1.0+(SamonAmount2)/100.0)
        }
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][8].contains("バハHP"){
                    bahaHP += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("バハ攻撃/HP"){
                    bahaHP += Double(WeaponCells[i][11]) ?? 0.0
                }else if WeaponCells[i][8].contains("オメガ基礎"){
                    bahaHP += Double(WeaponCells[i][11]) ?? 0.0
                }else if WeaponCells[i][8].contains("バハDATA"){
                    n_DA += Double(WeaponCells[i][10]) ?? 0.0
                    n_TA += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("オメガ闘争"){
                    n_def += 10.0
                    n_DA += 20.0
                    n_TA += 20.0
                }
                
                if WeaponCells[i][9].contains("バハHP"){
                    bahaHP += Double(WeaponCells[i][12]) ?? 0.0
                }else if WeaponCells[i][9].contains("バハ攻撃/HP"){
                    bahaHP += Double(WeaponCells[i][13]) ?? 0.0
                }else if WeaponCells[i][9].contains("バハDATA"){
                    n_DA += Double(WeaponCells[i][12]) ?? 0.0
                    n_TA += Double(WeaponCells[i][12]) ?? 0.0
                }else if WeaponCells[i][9].contains("オメガ闘争"){
                    n_DA += 20.0
                    n_TA += 20.0
                }
            }
        }
        
        if n_DA > 50.0{
            n_DA = 50.0
        }
        
        if n_TA > 50.0{
            n_TA = 50.0
        }
                
        
        
        
        return [n_def, m_def, ex_def, bahaHP, n_DA, m_DA, ex_DA, 0.0, n_TA, m_TA, ex_TA, 0.0]
    }
    
    func CulcHPAmount(WeaponCells:[[String]], Player:[String], element:String) -> [Double]{
        let rank = Double(Player[0]) ?? 1.0
        let favorite1 = Player[1]
        let favorite2 = Player[2]
        let bonusHP = Player[5]
        let samonHP = Player[7]
        var HPCells = CulcHP(WeaponCells: WeaponCells, Player: Player, element: element)
        var hp:Double = 0.0
        var culced_hp:Double = 0.0
        var weapon_hp = 0.0
        var cosmosList = [String]()
        var boukunCount:Int = 0
        
        for i in 0..<WeaponCells.count{
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][8].contains("バハHP"){
                    HPCells[3] += Double(WeaponCells[i][10]) ?? 0.0
                }else if WeaponCells[i][8].contains("バハ攻撃/HP"){
                    HPCells[3] += Double(WeaponCells[i][11]) ?? 0.0
                }else if WeaponCells[i][8].contains("オメガ基礎"){
                    HPCells[3] += Double(WeaponCells[i][11]) ?? 0.0
                }else if WeaponCells[i][8].contains("バハDATA"){
                    HPCells[4] += Double(WeaponCells[i][10]) ?? 0.0
                    HPCells[8] += Double(WeaponCells[i][10]) ?? 0.0
                }
            }
            
            if WeaponCells[i][8].contains("コスモス"){
                if cosmosList.index(of:WeaponCells[i][1]) == nil{
                    cosmosList.append(WeaponCells[i][1])
                }
            }
        }
        
        if rank <= 100.0{
            hp += 600.0 + (rank-1.0) * 8.0
        }else{
            hp += 1400.0 + (rank-101.0) * 4.0
        }
        
        
        for i in 0..<WeaponCells.count{
            weapon_hp = 0.0
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][8].contains("暴君") || WeaponCells[i][9].contains("暴君"){
                    boukunCount += 1
                }
                
                weapon_hp = Double(WeaponCells[i][5]) ?? 0.0
                if cosmosList != []{
                    for j in 0..<cosmosList.count{
                        if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2 && WeaponCells[i][1]==cosmosList[j]{
                            hp += weapon_hp * 1.5
                        }else if WeaponCells[i][1]==cosmosList[j]{
                            hp += weapon_hp*1.3
                        }else if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2{
                            hp += weapon_hp*1.2
                        }else{
                            hp += weapon_hp
                        }
                    }
                }else{
                    if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2{
                        hp += weapon_hp*1.2
                    }else{
                        hp += weapon_hp
                    }
                }
            }
            
            /*
            if WeaponCells[i][14] == "true"{
                if WeaponCells[i][1]==favorite1 || WeaponCells[i][1]==favorite2{
                    hp += Double(WeaponCells[i][5]) ?? 0.0 * 1.2
                }else{
                    hp += Double(WeaponCells[i][5]) ?? 0.0
                }
            }
            */
        }
        hp += Double(bonusHP) ?? 0.0
        hp += Double(samonHP) ?? 0.0
        
        
        culced_hp = hp*(1+HPCells[0]/100.0+HPCells[1]/100.0+HPCells[2]/100.0)
        
        culced_hp = culced_hp*(1.0-Double(boukunCount)/10.0)
        
        return [hp, culced_hp]
    }
    
    
}

