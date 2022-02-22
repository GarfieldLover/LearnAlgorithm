//
//  Lists.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class List链表: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

///单向链表
class ListNode<T: Equatable> {
    var value: T
    var next: ListNode?
    
    public init(value: T) {
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
    public func append(atHead new: T) {
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
    public func append(atTail new: T) {
        if let tail = _node(count - 1) {
            tail.next = ListNode(value: new)
            count += 1
        }
    }
    //插入节点
    public func insert(_ new: T, at i: Int) {
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
    public func remove(at index: Int) -> T? {
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
    public func removeFirst() -> T? {
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
    public func removeLast() -> T? {
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
    public func removeAll() {
        count = 0
        head = nil
    }
    
    /// 更新节点 ( Update node )
     /// - Parameters:
     ///   - index: 更新节点的位置
     ///   - newElement: 新节点
    public func update(at index: Int, _ new: T) {
        guard let curNode = _node(index) else { fatalError("Index out of range") }
        curNode.value = new
    }
    
    /// 获取节点值
    /// - Parameter index: 获取位置
    /// - Returns: 当前 index 的节点值
    @discardableResult
    public func index(of index: Int) -> T? {
        return _node(index)?.value
    }
    
    /// 是否包含 element
    /// - Parameter element: 需要查找的 element
    /// - Returns: 如果链表中包含该元素，返回 true，反之则返回 false
    public func contains(_ element: T) -> Bool {
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
    public func getAllElements() -> [T] {
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


/// 双链表的节点，通常你不需要直接使用该类。(Double linked list of nodes, usually you do not need to use this class directly)
public class DoubleLinkNode<T: Equatable> {
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
public class DoubleLinkedList<T: Equatable> {
    public var head: DoubleLinkNode<T>?
    public var tail: DoubleLinkNode<T>?
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
    public func append(atHead new: T) {
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
    public func append(atTail new: T) {
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
    public func insert(_ new: T, at i: Int) {
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
    public func remove(at index: Int) -> T? {
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
    public func removeFirst() -> T? {
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
    public func removeLast() -> T? {
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
    public func removeAll() {
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
    public func update(at index: Int, _ new: T) {
        guard let curNode = _node(index) else { fatalError("Index out of range") }
        curNode.val = new
    }
    
    /// 获取节点值
    /// - Parameter index: 获取位置
    /// - Returns: 当前 index 的节点值
    public func index(of index: Int) -> T? {
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
    public func contains(_ element: T) -> Bool {
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
    public func getAllElements() -> [T] {
        var nodes = [T]()
        var curNode = head
        while curNode != nil {
            nodes.append(curNode!.val)
            curNode = curNode?.next
        }
        
        return nodes
    }
}



/// 循环链表
public class CircularLinkedList<T: Equatable> {
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
    
    public func append(atHead new: T) {
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
        
        public func append(atTail new: T) {
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
        
        
        public func insert(_ new: T, at i: Int) {
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
        public func remove(at index: Int) -> T? {
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
        public func removeFirst() -> T? {
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
        public func removeLast() -> T? {
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

        public func removeAll() {
            count = 0
            head = nil
            tail = nil
        }
        
        
        public func update(at index: Int, _ new: T) {
            guard let curNode = _node(index) else { fatalError("Index out of range") }
            curNode.value = new
        }
        
        
        @discardableResult
        public func index(of index: Int) -> T? {
            return _node(index)?.value
        }
        

        public func contains(_ element: T) -> Bool {
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
        
        public func getAllElements() -> [T] {
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
