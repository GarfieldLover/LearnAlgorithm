//
//  Stacks.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Stack栈: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
}


//数组实现
public struct Stack<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func push(_ element: T) {
    array.append(element)
  }

  public mutating func pop() -> T? {
    return array.removeLast()
  }

  public var top: T? {
    return array.last
  }
}

//链表实现
/// 链表节点类
public class StackNode<T> {
    var value: T  // 值
    var next: StackNode<T>? = nil // 下一个节点
    weak var previous: StackNode<T>? = nil
    init(value: T) {
        self.value = value
    }
}

public class StackList<T> {
    public var count: Int = 0
    public var first: StackNode<T>?
    
    public var isEmpty: Bool {
      return count == 0
    }
    
    public func push(_ element: T) {
        let oldNode = first
        first = StackNode(value: element)
        first?.next = oldNode
        count += 1
    }
    
    public func pop() -> T? {
        let value = first?.value
        first = first?.next
        count -= 1
        return value
    }
}
