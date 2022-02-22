//
//  Dictionaries.swift
//  LearnAlgorithrn
//
//  Created by HU on 2022/2/16.
//

import UIKit

class Dictionary字典: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    ///创建字典
    func createArray(){

        var someDict =  [String: Int]()

        // namesOfIntegers 是一个空的 [Int: String] 字典
        var namesOfIntegers: [Int: String] = [:]
        
    }
    
    ///修改字典
    func modifyArray(){

        var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

        airports["LHR"] = "London"
        // airports 字典现在有三个数据项
        
        airports["LHR"] = "London Heathrow"
        // “LHR”对应的值被改为“London Heathrow”
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // 输出“The old value for DUB was Dublin.”
        
        airports["APL"] = "Apple Internation"
        // “Apple Internation”不是真的 APL 机场，删除它
        airports["APL"] = nil
        // APL 现在被移除了
        
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // 打印“The removed airport's name is Dublin Airport.”
    }
    
    ///遍历字典
    func ergodicArray(){
        
        var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // YYZ: Toronto Pearson
        // DUB: Dublin
        
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: DUB

        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: Dublin
        
        let airportCodes = [String](airports.keys)
        // airportCodes 是 ["YYZ", "LHR"]

        let airportNames = [String](airports.values)
        // airportNames 是 ["Toronto Pearson", "London Heathrow"]
    }
}
