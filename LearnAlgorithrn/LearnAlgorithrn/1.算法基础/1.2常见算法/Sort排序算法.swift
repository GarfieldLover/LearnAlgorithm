//
//  Sort排序算法.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Sort排序算法: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

struct Sort { }

extension Sort {
    /// 插入排序 - 时间复杂度 n²，稳定排序
    static func insertionSort(_ array: [Int]) -> [Int] {
        var a = array             // 1
        for x in 1..<a.count {         // 2
            var y = x
            while y > 0 && a[y] < a[y - 1] { // 3
                a.swapAt(y - 1, y)///Swift交换
                y -= 1
            }
        }
        return a
    }
    
    static func insertionSort1(_ array: [Int]) -> [Int] {
      var a = array
      for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
          a[y] = a[y - 1]                // 1
          y -= 1
        }
        a[y] = temp                      // 2
      }
      return a
    }
}

extension Sort {
    /// 冒泡排序 - 时间复杂度 n²，稳定排序
    /// - Parameter target: 待排序数组
    static func bubbleSort<E: Comparable>(target: [E]) -> [E] {
        var result = target
        for outIndex in stride(from: result.count - 1, through: 0, by: -1) {
            for inIndex in 0...outIndex {
                if result[outIndex] < result[inIndex] {
                    result.swapAt(outIndex, inIndex)
                }
            }
        }
        return result
    }
}

extension Sort {
    /// 快排 - 平均复杂度 nlogn，最坏复杂度n²，不稳定排序
    /// - Parameter target: 待排序数组
    static func quickSort(target: inout [Int]) {
        quickSort(target: &target, start: 0, end: target.count - 1)
    }
    
    static func quickSort(target: inout [Int], start: Int, end: Int) {
        guard start < end else { return }
        let pivot = partition(arr: &target, start: start, end: end)
        quickSort(target: &target, start: start, end: pivot - 1)
        quickSort(target: &target, start: pivot + 1, end: end)
    }
    
    private static func partition(arr: inout [Int], start: Int, end: Int) -> Int {
        let pivot = arr[start]
        var mark = start
        for idx in (start + 1)...end {
            if arr[idx] < pivot {
                mark += 1
                arr.swapAt(mark, idx)
            }
        }
        
        arr[start] = arr[mark]
        arr[mark] = pivot
        return mark
    }
}

extension Sort {
    /// 堆排 - 平均复杂度 nlogn，最坏复杂度nlogn，不稳定排序

}

extension Sort {
    /// 计数排序，时间复杂度 m+n，稳定排序
    /// - Parameter target:待排序数组
    /// 局限：最大值与最小值差距过大不适合；只适用整数
    static func countSort(target: [Int]) -> [Int] {
        let max = target.max() ?? 0
        let min = target.min() ?? 0
        
        var countNums = Array(repeating: 0, count: max - min + 1)
        target.forEach { countNums[$0 - min] += 1 }
        var result = [Int]()
        for idx in 0..<countNums.count {
            let seq = Array(repeating: idx + min, count: countNums[idx])
            result.append(contentsOf: seq)
        }
        return result
    }
    
    static func countSort1(target: [Int]) -> [Int] {
        let max = target.max() ?? 0
        let min = target.min() ?? 0
        var countNums = Array(repeating: 0, count: max - min + 1)
        
        for idx in 0..<target.count {
            let countIdx = target[idx] - min
            countNums[countIdx] += 1
        }
        
        for idx in 1..<countNums.count {
            countNums[idx] += countNums[idx - 1]
        }
        
        var sorted = Array(repeating: 0, count: target.count)
        for idx in stride(from: target.count - 1, through: 0, by: -1) {
            let sortedIdx = countNums[target[idx] - min] - 1
            sorted[sortedIdx] = target[idx]
            countNums[target[idx] - min] -= 1
            
        }
        return sorted
    }
}

//extension Sort {
//    /// 桶排序，时间复杂度 n，稳定排序
//    /// - Parameter target:待排序数组
//    /// 局限：时间复杂度可能退化到 nlogn
//    static func bucketSort(target: [Double]) -> [Double] {
//        let max = target.max() ?? 0.0
//        let min = target.min() ?? 0.0
//        let d = max - min
//        
//        let bucketNum = target.count
//        
//        var bucketList = Array(repeating: [Double](), count: target.count)
//        for idx in 0..<target.count {
//            let num = Int((target[idx] - min) * Double(bucketNum - 1) / d)
//            bucketList[num].append(target[idx])
//        }
//        
//        for idx in 0..<target.count {
//            bucketList[idx] = bucketList[idx].sorted()
//        }
//        
//        let sorted = bucketList.reduce([]) { (result, curr) -> [Double] in
//            return result + curr
//        }
//        
//        return sorted
//    }
//}
