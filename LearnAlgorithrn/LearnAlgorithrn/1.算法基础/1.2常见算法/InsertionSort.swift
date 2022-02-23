//
//  InsertionSort.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/23.
//

import UIKit

class InsertionSort: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let numbers = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
        
        let startTime = StartTime()
        let newNumbers = insertionSort(numbers, <)
        ConsumeTime(startTime)
        print("\(newNumbers)")
        
        
        
        
        
        insertionSort(numbers, >)

        let strings = [ "b", "a", "d", "c", "e" ]
        insertionSort(strings, <)
    }
    
    /// 插入排序 - 时间复杂度 n²，稳定排序
    ///排序原理和扑克牌一样,每次和前一张进行比较大小,小于就交换
    ///https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Insertion%20Sort
    @discardableResult
    public func insertionSort1<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var a = array             // 1
        for x in 1..<a.count {         // 2
            var y = x
            while y > 0 && isOrderedBefore(a[y], a[y-1]){ // 3
                a.swapAt(y - 1, y)///Swift交换 性能和临时变量差不多
                y -= 1
            }
        }
        return a
    }

    /*
     插入排序
     */
    @discardableResult
    public func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var a = array
        for x in 1..<a.count {
            var y = x
            let temp = a[y]
            while y > 0 && isOrderedBefore(temp, a[y-1]) {
                a[y] = a[y-1]
                y -= 1
            }
            a[y] = temp
        }
        return a
    }

}


