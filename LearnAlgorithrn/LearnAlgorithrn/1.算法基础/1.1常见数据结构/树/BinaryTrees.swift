//
//  BinaryTree.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/22.
//

import UIKit

class BinaryTrees: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

///二叉树
public class BinaryNode<T> {
    public var value: T
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public var parent: BinaryNode?
    
    public init(value: T) {
        self.value = value
        self.leftChild = nil
        self.rightChild = nil
        self.parent = nil
    }
    
    /// 是否是根节点
    public var isRoot: Bool {
        return parent == nil
    }
    /// 是否是叶节点
    public var isLeaf: Bool {
        return leftChild == nil && rightChild == nil
    }
    /// 是否是左子节点
    public var isLeftChild: Bool {
        return parent?.leftChild === self
    }
    /// 是否是右子节点
    public var isRightChild: Bool {
        return parent?.rightChild === self
    }
    /// 是否有左子节点
    public var hasLeftChild: Bool {
        return leftChild != nil
    }
    /// 是否有右子节点
    public var hasRightChild: Bool {
        return rightChild != nil
    }
    /// 是否有子节点
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    /// 是否左右两个子节点都有
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    /// 当前节点包括子树中的所有节点总数
    public var count: Int {
        return (leftChild?.count ?? 0) + 1 + (rightChild?.count ?? 0)
    }

}

public extension BinaryNode {
    ///中序遍历
    func traverseInOrder(visit: (T) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    ///前序遍历
    func traversePreOrder(visit: (T) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    ///后序遍历
    func traversePostOrder(visit: (T) -> Void) {
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
        visit(value)
    }
    
    
//
//    /// 层序遍历
//    /// - Parameter process: process
//    func traverseLevelOrder(process: (T) -> Void) {
//        var queue = [self]
//        while !queue.isEmpty {
//            let node = queue.removeFirst()
//            if let .node(left, value, right) = node {
//                process(value)
//                if case .node(_, _, _) = left { queue.append(left) }
//                if case .node(_, _, _) = right { queue.append(right) }
//            }
//        }
//    }
//
  /// 二叉树的最大深度
    func maxDepth(_ root: BinaryNode?) -> Int {
        if root == nil {
            return 0
        }
        let leftHeight = maxDepth(root?.leftChild)
        let rightHeigh = maxDepth(root?.rightChild)
        return max(leftHeight, rightHeigh) + 1
    }

    // 二叉树最小深度
    func minDepth(_ root: BinaryNode?) -> Int {
        if root == nil {
            return 0
        }
        let leftH = minDepth(root?.leftChild)
        let rightH = minDepth(root?.rightChild)
        if leftH != 0 && rightH != 0 {
            return min(leftH, rightH) + 1
        } else {
            return leftH + rightH + 1
        }
    }

    // 平衡二叉树
    func isBalanced(_ root: BinaryNode?) -> Bool {
        return dfsHeight(root) != -1
    }

    func dfsHeight(_ root: BinaryNode?) -> Int {
        if root == nil {
            return 0
        }
        let leftHeight = dfsHeight(root?.leftChild)
        if leftHeight == -1 {
            return -1
        }
        let rightHeight = dfsHeight(root?.rightChild)
        if rightHeight == -1 {
            return -1
        }
        if abs(leftHeight - rightHeight) > 1 {
            return -1
        }
        return max(leftHeight, rightHeight) + 1
    }

}
