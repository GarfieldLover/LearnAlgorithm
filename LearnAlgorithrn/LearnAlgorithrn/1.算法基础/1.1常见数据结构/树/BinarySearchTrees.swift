//
//  BinarySearchTree.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/22.
//

import UIKit

class BinarySearchTrees: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

///二叉搜索树
///每个左子节点小于其父节点，并且每个右子节点大于其父节点。 这是二叉搜索树的关键特性
///执行插入时，我们首先将新值与根节点进行比较。 如果新值较小，我们采取 左 分支; 如果更大，我们采取 右 分支。我们沿着这条路向下走，直到找到一个我们可以插入新值的空位。
public class SearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: SearchTree?
    private(set) public var left: SearchTree?
    private(set) public var right: SearchTree?
    
    public init(value: T) {
        self.value = value
    }
    /// 是否是根节点
    public var isRoot: Bool {
        return parent == nil
    }
    /// 是否是叶节点
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    /// 是否是左子节点
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    /// 是否是右子节点
    public var isRightChild: Bool {
        return parent?.right === self
    }
    /// 是否有左子节点
    public var hasLeftChild: Bool {
        return left != nil
    }
    /// 是否有右子节点
    public var hasRightChild: Bool {
        return right != nil
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
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    ///插入节点
    public func insert(value: T) {
      if value < self.value {
        if let left = left {
          left.insert(value: value)
        } else {
          left = SearchTree(value: value)
          left?.parent = self
        }
      } else {
        if let right = right {
          right.insert(value: value)
        } else {
          right = SearchTree(value: value)
          right?.parent = self
        }
      }
    }
    ///搜索节点,递归
    public func search(value: T) -> SearchTree? {
      if value < self.value {
        return left?.search(value: value)
      } else if value > self.value {
        return right?.search(value: value)
      } else {
        return self  // found it!
      }
    }
    ///搜索节点,循环
    public func search(_ value: T) -> SearchTree? {
      var node: SearchTree? = self
      while let n = node {
        if value < n.value {
          node = n.left
        } else if value > n.value {
          node = n.right
        } else {
          return node
        }
      }
      return nil
    }
    ///转换成数组(中序)
    public func map(formula: (T) -> T) -> [T] {
      var a = [T]()
      if let left = left { a += left.map(formula: formula) }
      a.append(formula(value))
      if let right = right { a += right.map(formula: formula) }
      return a
    }
    ///删除节点
    @discardableResult public func remove() -> SearchTree? {
      let replacement: SearchTree?

      // Replacement for current node can be either biggest one on the left or
      // smallest one on the right, whichever is not nil
      if let right = right {
        replacement = right.minimum()
      } else if let left = left {
        replacement = left.maximum()
      } else {
        replacement = nil
      }

      replacement?.remove()

      // Place the replacement on current node's position
      replacement?.right = right
      replacement?.left = left
      right?.parent = replacement
      left?.parent = replacement
      reconnectParentTo(node:replacement)

      // The current node is no longer part of the tree, so clean it up.
      parent = nil
      left = nil
      right = nil

      return replacement
    }

    private func reconnectParentTo(node: SearchTree?) {
      if let parent = parent {
        if isLeftChild {
          parent.left = node
        } else {
          parent.right = node
        }
      }
      node?.parent = parent
    }
    
    ///返回节点最小值和最大值
    public func minimum() -> SearchTree {
      var node = self
      while let next = node.left {
        node = next
      }
      return node
    }

    public func maximum() -> SearchTree {
      var node = self
      while let next = node.right {
        node = next
      }
      return node
    }
    ///获取树高度
    public func height() -> Int {
      if isLeaf {
        return 0
      } else {
        return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
      }
    }
    ///深度
    public func depth() -> Int {
      var node = self
      var edges = 0
      while let parent = node.parent {
        node = parent
        edges += 1
      }
      return edges
    }
    ///以排序顺序返回其值在当前值之前的节点
    public func predecessor() -> SearchTree<T>? {
      if let left = left {
        return left.maximum()
      } else {
        var node = self
        while let parent = node.parent {
          if parent.value < value { return parent }
          node = parent
        }
        return nil
      }
    }
    ///以排序顺序返回其值在当前值之后的节点
    public func successor() -> SearchTree<T>? {
      if let right = right {
        return right.minimum()
      } else {
        var node = self
        while let parent = node.parent {
          if parent.value > value { return parent }
          node = parent
        }
        return nil
      }
    }
    ///是否是有效的二叉搜索树
    public func isBST(minValue: T, maxValue: T) -> Bool {
      if value < minValue || value > maxValue { return false }
      let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
      let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
      return leftBST && rightBST
    }

}
