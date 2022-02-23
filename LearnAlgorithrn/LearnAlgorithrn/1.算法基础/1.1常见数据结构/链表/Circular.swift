//
//  Circular.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/22.
//

import UIKit

class Circular: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

/// 循环链表
class CircularLinkedList<T: Equatable> {
    /// 链表的头结点
    var head: ListNode<T>?
    /// 链表的尾结点
    var tail: ListNode<T>?
    
    /// 链表的长度
    private(set) var count = 0
    
    
    /// 内部获取节点的方法
    /// - Parameter index: 获取位置
    /// - Returns: 当前 index 的节点
    private func _node(_ index: Int) -> ListNode<T>? {
        guard index < count else {
            return nil
        }
        
        if index == 0 { return head }
        var curNode = head
        var curIndex = 0
        while curIndex < count {
            curNode = curNode?.next
            curIndex += 1
            if curIndex == index {
                break
            }
        }
        
        return curNode
    }
    
    func append(atHead new: T) {
            if head == nil {
                head = ListNode(value: new)
                tail = head
                tail?.next = tail
            } else {
                let newHead = ListNode(value: new)
                newHead.next = head
                head = newHead
                tail?.next = head
            }
            count += 1
        }
        
        func append(atTail new: T) {
            if tail != nil {
                let next = tail?.next
                if count == 1 {
                    tail = ListNode(value: new)
                    tail?.next = next
                    head?.next = tail
                } else {
                    tail = ListNode(value: new)
                    tail?.next = next
                }
            } else {
                tail = ListNode(value: new)
                tail?.next = tail
                head = tail
            }
            count += 1
        }
        
        
        func insert(_ new: T, at i: Int) {
            guard i <= count else { return }
            
            if i == 0 {
                append(atHead: new)
            } else if i == count {
                append(atTail: new)
            } else {
                if let curNode = _node(i - 1) {
                    let insertNode = ListNode(value: new)
                    insertNode.next = curNode.next
                    curNode.next = insertNode
                    count += 1
                }
            }
        }

        @discardableResult
        func remove(at index: Int) -> T? {
            guard head != nil else { return nil }
            guard index < count else { return nil }
            
            if index == 0 {
                return removeFirst()
            } else if index == count - 1 {
                return removeLast()
            } else {
                let prevTail = _node(index - 1)
                let val = prevTail?.next?.value
                prevTail?.next = prevTail?.next?.next
                
                count -= 1
                return val
            }
        }
        
        @discardableResult
        func removeFirst() -> T? {
            let val = head?.value
            if count == 1 {
                head = nil
                tail = nil
            } else {
                head = head?.next
                tail?.next = head
            }
            count -= 1
            return val
        }
        
        @discardableResult
        func removeLast() -> T? {
            guard head != nil else { return nil }
            let val: T?
            
            if count == 1 {
                val = head?.value
                head = nil
                tail = nil
            } else {
                let prevTail = _node(count - 2)
                val = prevTail?.next?.value
                prevTail?.next = prevTail?.next?.next
            }
            count -= 1
            return val
        }

        func removeAll() {
            count = 0
            head = nil
            tail = nil
        }
        
        
        func update(at index: Int, _ new: T) {
            guard let curNode = _node(index) else { fatalError("Index out of range") }
            curNode.value = new
        }
        
        
        @discardableResult
        func index(of index: Int) -> T? {
            return _node(index)?.value
        }
        

        func contains(_ element: T) -> Bool {
            guard head != nil else { return false }
            
            var curNode = head
            while curNode != nil {
                if curNode!.value == element {
                    return true
                }
                curNode = curNode?.next
            }
            return false
        }
        
        func getAllElements() -> [T] {
            guard count > 0 else { return [] }
            var nodes = [T]()
            var curNode = head
            while curNode?.next?.value != head?.value {
                nodes.append(curNode!.value)
                curNode = curNode?.next
            }
            
            nodes.append(curNode!.value)
            return nodes
        }
}


struct LinkedListPractice {
    /// 链表是否有环
    /// - Parameter head: 链表
    static func hasCycle(head: ListNode<Int>?) -> Bool {
        guard head != nil else { return false }
        var fast = head
        var slow = head
        while true {
            guard fast != nil && fast?.next != nil else { return false }
            fast = fast?.next?.next
            slow = slow?.next
            if slow?.value == fast?.value {
                return true
            }
        }
    }
    
    /// 计算环的长度
    /// - Parameter head: 头结点
    static func cycleLength(head: ListNode<Int>?) -> Int {
        guard head != nil else { return -1 }
        var slow = head
        var fast = head
        while true {
            guard fast != nil && fast?.next != nil else { return -1 }
            fast = fast?.next?.next
            slow = slow?.next
            if slow?.value == fast?.value {
                break
            }
        }
        
        guard slow?.value == fast?.value else { return -1 }
        
        var count = 1
        fast = fast?.next?.next
        slow = slow?.next
        while slow?.value != fast?.value {
            fast = fast?.next?.next
            slow = slow?.next
            count += 1
        }
        
        return count
    }
    
    /// 寻找环形链表的入口节点
    /// - Parameter head: 头结点
    static func cycleEntrance(head: ListNode<Int>?) -> ListNode<Int>? {
        guard head != nil else { return nil }
        var slow = head
        var fast = head
        while true {
            guard fast != nil && fast?.next != nil else { return nil }
            fast = fast?.next?.next
            slow = slow?.next
            if slow?.value == fast?.value {
                break
            }
        }
        
        guard slow?.value == fast?.value else { return nil }
        slow = head
        while slow?.value != fast?.value {
            slow = slow?.next
            fast = fast?.next
        }
        return slow
    }
}
