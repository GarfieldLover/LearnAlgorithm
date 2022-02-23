//
//  SelectionSort.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/23.
//

import UIKit

class SelectionSort: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Selection%20Sort
        let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
        let startTime = StartTime()
        let newList = selectionSort(list, <)
        ConsumeTime(startTime)
        print("\(newList)")
        
    }

    ///O(n^2)
    ///泛型版本
    public func selectionSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        //如果数组为空或仅包含单个元素，则无需排序
        guard array.count > 1 else { return array }
        //生成数组的副本
        var a = array
        //函数内有两个循环。 外循环依次查看数组中的每个元素
        for x in 0 ..< a.count - 1 {
            
            //内循环实现找到数组其余部分中的最小数字
            var lowest = x
            for y in x + 1 ..< a.count {
                if isOrderedBefore(a[y], a[lowest]) {
                    lowest = y
                }
            }
            //使用当前数组索引数字交换最小数字
            if x != lowest {
                a.swapAt(x, lowest)
            }
        }
        return a
    }
    
}
