//
//  Double.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/22.
//

import UIKit

class Double: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

/// 双链表的节点
class DoubleLinkNode<T: Equatable> {
    var val: T
    var next: DoubleLinkNode?
    var prev: DoubleLinkNode?
    
    init(prev: DoubleLinkNode?, val: T, next: DoubleLinkNode?) {
        self.prev = prev
        self.val = val
        self.next = next
    }
    
    static func == (lhs: DoubleLinkNode, rhs: DoubleLinkNode) -> Bool {
        return lhs.val == rhs.val
    }
}

/// 双向链表  (Double linked list)
class DoubleLinkedList<T: Equatable> {
    var head: DoubleLinkNode<T>?
    var tail: DoubleLinkNode<T>?
    private(set) var count = 0
    
    /// 获取节点  (Get node)
    /// - Parameter index: 获取位置 (Index)
    /// - Returns: 当前 index 的节点 (The node of the current index)
    private func _node(_ index: Int) -> DoubleLinkNode<T>? {
        guard index < count else {
            return nil
        }
        
        if index == 0 { return head }
        if index == count - 1 { return tail }
        var curNode: DoubleLinkNode<T>?
        var curIndex = index
        if index < count/2 { // 前半段 (The first half)
            curNode = head
            while curIndex > 0 {
                curNode = curNode?.next
                curIndex -= 1
            }
            
        } else { // 后半段 (The second half)
            curNode = tail
            curIndex = count - 1
            
            while curIndex > index {
                curNode = curNode?.prev
                curIndex -= 1
            }
        }
        return curNode
    }

    /// 在链表头部添加节点 ( Add a node to the head of the linked list )
    /// - Parameter newElement: 添加的节点
    func append(atHead new: T) {
        if head == nil {
            head = DoubleLinkNode(prev: nil, val: new, next: nil)
            tail = head
        } else {
            let newHead = DoubleLinkNode(prev: nil, val: new, next: head)
            head?.prev = newHead
            head = newHead
        }
        count += 1
    }
    
    /// 在链表尾部添加节点 ( Add node at the end of the list )
     /// - Parameter newElement: 添加的节点
    func append(atTail new: T) {
        if tail == nil {
            tail = DoubleLinkNode(prev: nil, val: new, next: nil)
            head = tail
        } else {
            let newTail = DoubleLinkNode(prev: tail, val: new, next: nil)
            if tail?.prev == nil {
                head?.next = newTail
            } else {
                tail?.next = newTail
            }
            tail = newTail
        }
        
        count += 1
    }
    
    /// 插入节点 ( Insert node )
    /// - Parameters:
    ///   - newElement: 添加的节点
    ///   - i: 添加的位置
    func insert(_ new: T, at i: Int) {
        guard i < count else { return }
        
        if i == 0 {
            append(atHead: new)
        } else if i == count {
            append(atTail: new)
        } else {
            if let curNode = _node(i - 1) {
                let insertNode = DoubleLinkNode(prev: curNode, val: new, next: curNode.next)
                
                curNode.next?.prev = insertNode
                curNode.next = insertNode
                count += 1
            }
        }
    }
    
    /// 移除节点 ( Remove node )
    /// - Parameter index: 移除的位置
    /// - Returns: 被移除的节点
    @discardableResult
    func remove(at index: Int) -> T? {
        guard head != nil else { return nil }
        
        if index == 0 {
            return removeFirst()
        } else if index == count {
            return removeLast()
        } else {
            let node = _node(index)
            let old = node
            
            node?.prev?.next = node?.next
            node?.next?.prev = node?.prev
            
            count -= 1
            return old?.val
        }
    }
    
    /// 移除头部节点 ( Remove head node )
    /// - Returns: 被移除的节点
    func removeFirst() -> T? {
        guard head != nil else {
            return nil
        }
        
        count -= 1
        
        let old = head
        head = head?.next
        head?.prev = nil
        return old?.val
    }
    
    /// 移除尾部节点  ( Remove tail node )
    /// - Returns: 被移除的节点
    func removeLast() -> T? {
        guard tail != nil else {
            return nil
        }
        
        count -= 1
        
        let old = tail
        tail = tail?.prev
        tail?.next = nil
        return old?.val
    }
    /// 移除所有节点
    func removeAll() {
        // 将所有元素置空 (Empty all elements)
        var curNode = head
        while curNode != nil {
            let tempNext = curNode?.next
            curNode?.next = nil
            curNode?.prev = nil
            curNode = tempNext
        }
        
        head = nil
        tail = nil
        count = 0
    }
    
    /// 更新节点 ( Update node )
    /// - Parameters:
    ///   - index: 更新节点的位置
    ///   - newElement: 新节点
    func update(at index: Int, _ new: T) {
        guard let curNode = _node(index) else { fatalError("Index out of range") }
        curNode.val = new
    }
    
    /// 获取节点值
    /// - Parameter index: 获取位置
    /// - Returns: 当前 index 的节点值
    func index(of index: Int) -> T? {
        if index == 0 {
            return head?.val
        } else if index == count - 1 {
            return tail?.val
        } else {
            return _node(index)?.val
        }
    }
    
    /// 是否包含 element
    /// - Parameter element: 需要查找的 element
    /// - Returns: 如果链表中包含该元素，返回 true，反之则返回 false
    func contains(_ element: T) -> Bool {
        guard head != nil else { return false }
        
        var curNode = head
        while curNode != nil {
            if curNode!.val == element {
                return true
            }
            curNode = curNode?.next
        }
        return false
    }
    
    /// 获取链表所有元素 (Get all the elements of the linked list)
    /// - Returns: 返回包含链表所有元素的数组
    func getAllElements() -> [T] {
        var nodes = [T]()
        var curNode = head
        while curNode != nil {
            nodes.append(curNode!.val)
            curNode = curNode?.next
        }
        
        return nodes
    }
}
