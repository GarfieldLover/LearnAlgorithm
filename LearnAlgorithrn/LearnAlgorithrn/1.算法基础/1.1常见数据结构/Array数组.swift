//
//  Array.swift
//  LearnAlgorithrn
//
//  Created by HU on 2022/2/16.
//

import UIKit

class Array数组: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 学习算法的基础.掌握常见数据结构
        /// 某些企业要求手写代码,上机或上线码测,掌握或补习基础比较重要,尤其是外企,我的目标就是争取在本职语言的基础上熟悉算法,刷题,然后再学习Python,下一步就是研究ROS2的机器人路径规划等算法.
        /// 以下资料来自官方教程.最新语言版本
        ///https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html
    }
    
    struct SomeType {
        var value : String = ""
    }
    
    ///创建数组
    func createArray(){
        ///初始化任意类型数组
        
        let arr : [SomeType] = []
        
        var someArray = [SomeType]()
        ///设置容量
        someArray.reserveCapacity(100)
        
        
        ///创建一个初始化大小数组.repeating:创建数组的初始值,count:数组大小
        var someStrs = [String](repeating: "初始值", count: 3)
        var someInts = [Int](repeating: 0, count: 3)
    }
    
    ///修改数组
    func modifyArray(){
        ///使用 append() 方法或者赋值运算符 += 在数组末尾添加元素
        var someInts = [Int]()
        someInts.append(20)
        someInts.append(30)
        someInts += [40]
        someInts += [70, 80, 90]
        /// 修改一个元素
        someInts[2] = 50
        
        ///插入元素
        someInts.insert(100, at: 2)
        
        ///删除元素
        someInts.remove(at: 0)
        someInts.removeLast()
        someInts.removeFirst()
        someInts.removeAll()
    }
    
    ///访问元素
    func accessArray(){
        var someYearArr = [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
        ///访问数组元素
        var someVar = someYearArr[2]
        ///访问区间元素 下标值从2到6(不包含下标值为6)
        var someVars = someYearArr[2..<6]
        ///访问区间元素 下标值从2到6(包含下标值为6)
        var someVars1 = someYearArr[2...6]
    }
    
    ///检查数组中是否包含指定元素
    func contains(){
        var someYearArr = [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
        
        var isHave = someYearArr.contains(2013)
    }
    
    ///遍历数组
    func ergodicArray(){
        var someStrs = [String]()
        someStrs.append("Apple")
        someStrs.append("Amazon")
        someStrs.append("Runoob")
        someStrs += ["Google"]

        //使用for-in循环
        for item in someStrs {
           print(item)
        }
        //元组遍历、enumerated()
        for (index, item) in someStrs.enumerated() {
            print("在 index = \(index) 位置上的值为 \(item)")
        }
        //区间下标遍历
        for i in 0..<someStrs.count{
           print(someStrs[i])
        }

        //forEach 遍历
        someStrs.forEach { value in
            print(value)
        }
        
        ///While 循环
        ///while 循环从计算一个条件开始。如果条件为 true，会重复运行一段语句，直到条件变为 false。
//        while condition {
//            statements
//        }
        
    }
}
///Array有以下几个高阶函数：filter map reduce flatMap compactMap。其中前三个和JavaScript语言是一样的
/**
 filter函数
 过滤，将数组中的元素按照一定的条件进行过滤 返回过滤后新数组
 传入函数/闭包表达式
 该函数/闭包表达式会执行n次，n代表数组中元素个数
 该函数/闭包表达式 必须返回Bool类型
 该函数/闭包表达式 接收一个参数，该参数就是每次遍历的数组中元素
 如果函数/闭包表达式返回值是true 就把该元素放入新的数组
 如果函数/闭包表达式返回值是false 该元素就会被过滤掉
 let array = [1, 2, 3, 4]
 let newArray = array.filter { (n) -> Bool in
     return n % 2 == 0
 }
 print(newArray) // [2, 4]

 // 利用Swift语言的语法糖 上面的代码还可以进行进一步的简化
 let newArray = array.filter { $0 % 2 == 0 }
 print(newArray) // [2, 4]
 */

/**
 map函数
 将数组中元素进行映射处理，返回处理过后的新数组
 传入函数/闭包表达式
 该函数/闭包表达式会执行n次，n代表数组中元素个数
 该函数/闭包表达式接收一个参数，该参数就是每次遍历的数组元素
 该函数/闭包表达式返回处理后的内容，将处理后的内容添加到新的数组中（映射操作）

 let array = [1, 2, 3, 4]
 let newArray = array.map { n in
     return n * 2
 }
 print(newArray) // [2, 4, 6, 8]

 // 简写
 let newArray = array.map { $0 * 2 }
 print(newArray) // [2, 4, 6, 8]
 */

/**
 flatMap函数
 flatMap传入的函数/闭包表达式 必须返回sequence类型
 最终的返回值将sequence中的元素放入到新的数组中
 而map传入的函数/闭包表达式 直接将数组作为元素放入到新的数组中

 let array = [1, 2, 3, 4]
 let newArray = array.map { n in
     return Array(repeating: n, count: n)
 }
 print(newArray) // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

 let newArray2 = array.flatMap { n in
     return Array(repeating: n, count: n)
 }
 print(newArray2) // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

 // 简写
 let newArray = array.flatMap { Array(repeating: $0, count: $0) }
 print(newArray) // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
 */

/**
 compactMap函数
 compactMap在进行元素映射的时候，会将nil过滤掉，并且会将可选项进行解包

 let array = ["1", "flutter", "3", "Vue"]

 let newArray = array.map { item in
     return Int(item)
 }
 print(newArray) // [Optional(1), nil, Optional(3), nil]

 let newArray2 = array.compactMap { item  in
     return Int(item)
 }

 print(newArray2) // [1, 3]

 // 简写
 let newArray = array.compactMap { Int($0) }
 print(newArray) // [1, 3]
 */

/**
 reduce函数
 汇总或者数组中每个元素的值和前一个值有关联的处理
 传入初始值和一个函数/闭包表达式
 该函数/闭包表达式会执行n次，n代表数组中元素个数
 该函数/闭包表达式接收2个参数，上一次遍历汇总的结果，和数组中的元素
 将汇总的结果作为返回值返回

 let array = [1, 2, 3, 4]
 let result = array.reduce(0) { (previousResult, n) in
     return previousResult + n
 }
 print(result) // 10

 // 简写
 let result = array.reduce(0) { $0 + $1 }
 print(result) // 10
 */
