//
//  Heap堆.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Heaps: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*
     堆形数据结构是一个二叉树，可以通过数组构造。
     堆分为最大堆和最小堆：
     最大堆节点的值比子节点的值更大，根节点的值最大，
     最小堆节点的值比子节点的值更小，根节点的值最小。
     
     10
     /   \
     7     9
     / \   / \
     6   4 5   3
     
     1
     /   \
     2     3
     / \   / \
     6   8 9   7
     
     
     
     
     10       第一层
     -----------------------
     /   \
     7     9    第二层
     -----------------------
     / \   / \
     6   4 5   3  第三层
     -----------------------
     /
     2               第四层
     -----------------------
     
     用数组表示
     索引     0      1     2     3     4     5     6     7
     +-------------------------------------------------+
     |  10  |  7  |  9  |  6  |  4  |  5  |  3  |  2   |
     +-------------------------------------------------+
     
     |第一层 |   第二层   |         第三层         |第四层 |
     |------|-----------|-----------------------|------|
     
     
     */
    
}
///https://juejin.cn/post/6874956994847965191
struct Heap<Element: Equatable> {
    //存放元素的数组
    private(set) var elements: [Element] = []
    //比较两个元素大小
    private let order: (Element, Element) -> Bool
    
    init(order: @escaping (Element, Element) -> Bool) {
        self.order = order
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    var peek: Element? {
        return elements.first
    }
    //当前节点的左树
    func leftChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 1
    }
    ///当前节点的右树
    func rightChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 2
    }
    //当前节点的父节点
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
    
}

extension Heap: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}


extension Heap {
    
    //插入
    mutating func insert(_ element: Element) {
        elements.append(element)
        validateUp(from: elements.count - 1)
    }
    
    //移除分两种情况：1）移除根部元素；2）移除任意位置的元素。
    //    首先判断堆是否为空，如果是直接返回 nil。
    //    调换根元素和最后一个元素
    //    移除最后一个元素
    @discardableResult
    mutating func removePeek() -> Element? {
        guard !isEmpty else {
            return nil
        }
        //将第一个节点和最后一个交换位置
        elements.swapAt(0, count - 1)
        defer {
            //向下判断新的第一个节点是不是优先级最高的节点
            validateDown(from: 0)
        }
        //返回删除第一个,也就是原来的最后一个
        return elements.removeLast()
    }
    
    @discardableResult
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                validateDown(from: index)
                validateUp(from: index)
            }
            return elements.removeLast()
        }
    }

    //递归实现https://blog.csdn.net/weixin_34050005/article/details/88027632
    private mutating func validateUp(from index: Int) {
        
        var childIndex = index
        //获取父节点的索引
        var parentIndex = self.parentIndex(ofChildAt: childIndex)
        //如果当前节点不是根节点,比较当前节点和父节点的优先级
        while childIndex > 0 &&
                order(elements[childIndex], elements[parentIndex]) {
            //如果当前节点的优先级高于父节点,交换位置
            elements.swapAt(childIndex, parentIndex)
            //到下一个节点从新的父节点开始向上继续
            childIndex = parentIndex
            //
            parentIndex = self.parentIndex(ofChildAt: childIndex)
        }
    }
    
    private mutating func validateDown(from index: Int) {
        //从当前节点及子节点中找出优先级最高的节点
        //如果当前节点是则返回
        //如果不是优先级最高的节点,就和优先级高的节点交换位置
        //然后再从新的节点开始继续向下判断优先级
        var parentIndex = index
        while true {
            let leftIndex = leftChildIndex(ofParentAt: parentIndex)
            let rightIndex = rightChildIndex(ofParentAt: parentIndex)
            var targetParentIndex = parentIndex
            
            if leftIndex < count &&
                order(elements[leftIndex], elements[targetParentIndex]) {
                targetParentIndex = leftIndex
            }
            
            if rightIndex < count &&
                order(elements[rightIndex], elements[targetParentIndex]) {
                targetParentIndex = rightIndex
            }
            
            if targetParentIndex == parentIndex {
                return
            }
            
            elements.swapAt(parentIndex, targetParentIndex)
            parentIndex = targetParentIndex
        }
    }

}
// MARK: - Search
extension Heap {
    func index(of element: Element,
               searchingFrom index: Int = 0) -> Int? {
        if index >= count {
            return nil
        }
        if order(element, elements[index]) {
            return nil
        }
        if element == elements[index] {
            return index
        }
        
        let leftIndex = leftChildIndex(ofParentAt: index)
        if let i = self.index(of: element,
                              searchingFrom: leftIndex) {
            return i
        }
        
        let rightIndex = rightChildIndex(ofParentAt: index)
        if let i = self.index(of: element,
                              searchingFrom: rightIndex) {
            return i
        }
        
        return nil
    }
}
