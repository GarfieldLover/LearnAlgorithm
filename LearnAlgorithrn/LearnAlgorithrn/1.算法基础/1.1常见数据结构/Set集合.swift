//
//  Set.swift
//  LearnAlgorithrn
//
//  Created by HU on 2022/2/16.
//

import UIKit


class Set集合: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    struct SomeType: Hashable{
        var value : String = ""
    }
    
    ///创建集合
    func createSets(){
        //  创建一个空的Int集合
        var set1 = Set<Int>()
        //  通过字面量创建Int结合
        var set2: Set<Int> = [1, 2, 3]
        //  创建自定义类型集合,因为唯一,所以需要hash比对
        var set3: Set<SomeType> = []
    }
    
    ///修改集合
    func modifySets(){

        var someInts = Set<String>()
        ///插入元素
        someInts.insert("1")
        
        ///删除元素
        someInts.remove("1")
        someInts.removeAll()

    }

    ///检查集合中是否包含指定元素
    func contains(){
        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        
        let isHave = favoriteGenres.contains("Funk")
    }
    
    ///遍历集合
    func ergodicArray(){
        let favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        
        //使用for-in循环
        for genre in favoriteGenres {
           print(genre)
        }

        //forEach 遍历
        favoriteGenres.forEach { value in
            print(value)
        }
    }
}
