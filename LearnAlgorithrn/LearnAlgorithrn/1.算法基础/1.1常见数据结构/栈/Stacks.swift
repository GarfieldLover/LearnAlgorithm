//
//  Stacks.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Stacks: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
}


//数组实现
struct Stack<T> {
  fileprivate var array = [T]()

  var isEmpty: Bool {
    return array.isEmpty
  }

  var count: Int {
    return array.count
  }

  mutating func push(_ element: T) {
    array.append(element)
  }

  mutating func pop() -> T? {
    return array.removeLast()
  }

  var top: T? {
    return array.last
  }
}

//链表实现
/// 链表节点类
class StackNode<T> {
    var value: T  // 值
    var next: StackNode<T>? = nil // 下一个节点
    weak var previous: StackNode<T>? = nil
    init(value: T) {
        self.value = value
    }
}

class StackList<T> {
    var count: Int = 0
    var first: StackNode<T>?
    
    var isEmpty: Bool {
      return count == 0
    }
    
    func push(_ element: T) {
        let oldNode = first
        first = StackNode(value: element)
        first?.next = oldNode
        count += 1
    }
    
    func pop() -> T? {
        let value = first?.value
        first = first?.next
        count -= 1
        return value
    }
}
