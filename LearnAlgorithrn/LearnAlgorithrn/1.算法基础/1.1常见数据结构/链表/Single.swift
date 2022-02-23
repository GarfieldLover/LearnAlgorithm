//
//  SingleList.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/22.
//

import UIKit
///单向链表
class Single: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 使用链表的典型示例是队列。 使用数组，从队列前面删除元素很慢，因为它需要向下移动内存中的所有其他元素。 但是通过链接链表，只需将head更改为指向第二个元素即可。 快多了
    }

}
///链表节点
class ListNode<T: Equatable> {
    var value: T
    var next: ListNode?
    
    init(value: T) {
        self.value = value
    }
    
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.value == rhs.value
    }
}

extension ListNode: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value)" + "\(String(describing: next))"
    }
}

class SingleList<T: Equatable> {
    /// 链表的头结点
    var head: ListNode<T>?
    /// 链表的长度
    private(set) var count = 0
    
    var isEmpty: Bool {
        return head == nil
    }
    
    /// 内部获取节点的方法
    /// - Parameter index: 获取位置
    /// - Returns: 当前 index 的节点
    private func _node(_ index: Int) -> ListNode<T>? {
        guard index < count else {
            return nil
        }
        
        if index == 0 { return head }
        var curNode = head
        var curIndex = index
        
        while curIndex > 0 {
            curNode = curNode?.next
            curIndex -= 1
        }
        return curNode
    }
    
    // 头部追加
    func append(atHead new: T) {
        if isEmpty {
            head = ListNode(value: new)
        } else {
            let newHead = ListNode(value: new)
            newHead.next = head
            head = newHead
        }
        count += 1
    }
    
    //尾部添加
    func append(atTail new: T) {
        if let tail = _node(count - 1) {
            tail.next = ListNode(value: new)
            count += 1
        }
    }
    //插入节点
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
    
    //删除指定索引的节点
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
    // 删除第一个节点
    @discardableResult
    func removeFirst() -> T? {
        let val = head?.value
        if count == 1 {
            head = nil
        } else {
            head = head?.next
        }
        count -= 1
        return val
    }
    
    // 删除最后一个节点
    @discardableResult
    func removeLast() -> T? {
        guard head != nil else { return nil }
        
        if count == 1 {
            let val = head?.value
            head = nil
            
            count -= 1
            return val
        } else {
            let prevTail = _node(count - 2)
            let val = prevTail?.next?.value
            prevTail?.next = prevTail?.next?.next
            
            count -= 1
            return val
        }
    }
    // 删除所有的节点
    func removeAll() {
        count = 0
        head = nil
    }
    
    /// 更新节点 ( Update node )
     /// - Parameters:
     ///   - index: 更新节点的位置
     ///   - newElement: 新节点
    func update(at index: Int, _ new: T) {
        guard let curNode = _node(index) else { fatalError("Index out of range") }
        curNode.value = new
    }
    
    /// 获取节点值
    /// - Parameter index: 获取位置
    /// - Returns: 当前 index 的节点值
    @discardableResult
    func index(of index: Int) -> T? {
        return _node(index)?.value
    }
    
    /// 是否包含 element
    /// - Parameter element: 需要查找的 element
    /// - Returns: 如果链表中包含该元素，返回 true，反之则返回 false
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
    
    /// 获取链表所有元素 (Get all the elements of the linked list)
    /// - Returns: 返回包含链表所有元素的数组
    func getAllElements() -> [T] {
        var nodes = [T]()
        var curNode = head
        while curNode != nil {
            nodes.append(curNode!.value)
            curNode = curNode?.next
        }
        
        return nodes
    }
    
    
    ///反转链表节点
    var tail: ListNode<T>?
    // 反转
    func reverse() {
        var prev = head
        var current = head?.next
        // 头部变尾部
        tail = head
        // 最后一个节点没有next
        tail?.next = nil
        while current != nil {          // 直到 current 为 nil
            let next = current?.next    // 获取下一个节点
            current?.next = prev        // 重新设置下一个节点
            prev = current              // 向前移动
            current = next              // 向后移动
        }
        head = prev
    }
    
    // 找到尾部
    func trackTailNode() {
        guard !isKnownUniquelyReferenced(&head) else { return }
        guard var oldNode = head else { return }
        // 重置 head
        head = ListNode(value: oldNode.value)
        // 初始化变量
        var newNode = head
        // 遍历直到找到尾部节点
        while let nextOldNode = oldNode.next {
            newNode?.next = ListNode(value: nextOldNode.value)
            newNode = newNode?.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
    
    // 打印
    func printInReverse<T>(_ node: ListNode<T>?) {
        guard let node = node else { return }
        printInReverse(node.next)
        print(node.value)
    }
}
