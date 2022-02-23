//
//  BubbleSort.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/23.
//

import UIKit

class BubbleSort: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nums = [3,42,1,5,34,20,9]
        print("\(bubbleSort(nums))")
    }
    
    func bubbleSort(_ numbers:  [Int]) -> [Int]{
        var nums = numbers
        let n = nums.count
        for i in 0..<n {
            for j in 0..<(n - 1 - i) {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
        return nums
    }

}
