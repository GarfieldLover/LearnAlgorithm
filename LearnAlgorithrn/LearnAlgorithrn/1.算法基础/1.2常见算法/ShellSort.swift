//
//  ShellSort.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/23.
//

import UIKit

class ShellSort: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var arr = [34, 32, 50, 23, 73, 2, -1, 42, 31, 5]

        shellSort(&arr)

        print(arr)
    }
    
    ///将原始列表分成较小的子列表，然后使用插入排序对其进行单独排序。
//    希尔排序的性能为O(n^2)，如果幸运，则为 O(nlogn)。 该算法是不稳定的排序
    public func shellSort(_ list: inout [Int]) {
        //首先将数组的长度除以2,这是 gap 大小
        var sublistCount = list.count / 2
        while sublistCount > 0 {
            for pos in 0 ..< sublistCount {
                insertSort(&list, start: pos, gap: sublistCount)
            }
            sublistCount = sublistCount / 2
        }
    }

    public func insertSort(_ list: inout[Int], start: Int, gap: Int) {
        for i in stride(from: (start + gap), to: list.count, by: gap) {
            let currentValue = list[i]
            var pos = i
            while pos >= gap && list[pos - gap] > currentValue {
                list[pos] = list[pos - gap]
                pos -= gap
            }
            list[pos] = currentValue
        }
    }

}
