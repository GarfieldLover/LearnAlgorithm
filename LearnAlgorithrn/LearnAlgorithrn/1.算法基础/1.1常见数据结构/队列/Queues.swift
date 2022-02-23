//
//  Queues.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Queues: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//数组队列
struct Queue<T> {
  fileprivate var array = [T]()

  var isEmpty: Bool {
    return array.isEmpty
  }
  
  var count: Int {
    return array.count
  }

  mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  mutating func dequeue() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }
  
  var front: T? {
    return array.first
  }
}

//链表队列
/// 链表节点类
class QueueNode<T> {
    var value: T? // 值
    var next: QueueNode<T>? = nil // 下一个节点
    weak var previous: QueueNode<T>? = nil
    init(value: T?) {
        self.value = value
    }
}

class QueueByLinkList<T> {
    var count: Int = 0
    var first: QueueNode<T>?
    var last: QueueNode<T>?
    
    var isEmpty: Bool {
      return count == 0
    }
    
    //初始化队列
    init() {
        first = QueueNode(value: nil)
        last = first
        count = 0
    }
    
    //入队
    func enqueue(_ element: T) {
        if isEmpty {
            ///为空
            last?.value = element
            count += 1
            return
        }
        let oldNode = last
        last = QueueNode(value: element)
        oldNode?.next = last
        count += 1
    }
    
    //出队
    func dequeue(_ element: T) -> T? {
        if isEmpty {
            print("***队列为空***")
            return nil
        }
        let value = first?.value
        first = first?.next
        count -= 1
        return value
    }
}

//循环队列
struct CycleQueue<T> {
    fileprivate var queue = [T]()
    fileprivate var queue_Capacity: Int = 0
    
    var count: Int {
        return queue.count
    }
    
    // 构造函数创建出一个队列数据模型来
    init(queue_Capacity: Int) {
        self.queue_Capacity = queue_Capacity
        self.clearQueue()
    }
    
    /// 清空队列
    mutating func clearQueue() {
        queue.removeAll()
    }
    
    /// 判断队列是否已经满了
    func queueFull() -> Bool {
        return queue_Capacity == count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }

    /// 往队列中添加一个元素
    mutating func enQueue(_ element : T) -> Bool {
        if queueFull() {
            print("队列已满")
            return false
        } else {
            queue.append(element)
            return true
        }
    }
  
    /// 从队列中取出来一个元素 如果队列为空 那么 取出来的为 nil
    mutating func deQueue() -> T? {
         if isEmpty {
            return nil
        } else {
            let element = queue.removeFirst()
            return element
        }
    }
     /// 遍历队列
    func queueTraverse() {
        if isEmpty {
            print("队列为空")
        } else {
            queue.forEach { (element) in
                print("element: \(element)")
            }
        }
    }
}
