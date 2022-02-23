//
//  AVLTree.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/22.
//

import UIKit

class AVLTrees: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // AVL树是二叉搜索树的自平衡形式，其中子树的高度最多只相差1
        // 所有的子节点都在左侧分支，没有一个在右侧分支。 这与链表基本相同。 因此，搜索需要 O(n) 时间，而不是您期望从二叉搜索树获得的更快的 O(log n) 。
    }
 
}


class AvlTree<T: Comparable>{
    
    class AVLTreeNode {
        var value: T
        var parent: AVLTreeNode?
        var left: AVLTreeNode?
        var right: AVLTreeNode?
        var height: Int = 1

        init(value: T) {
            self.value = value
        }
    }
    
    
    private var root: AVLTreeNode?
    private var size: Int
    
    init() {
        root = nil
        size = 0
    }
    
    //获取某一结点的高度
    private func getHeight(node: AVLTreeNode?) -> Int {
        guard let node = node else {
            return 0
        }
        return node.height
    }
    
    func getSize() -> Int {
        return size
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    /**
     * 获取节点的平衡因子
     * @param node
     * @return
     */
    private func getBalanceFactor(node: AVLTreeNode?) -> Int {
        guard let node = node else {
            return 0
        }
        return abs(getHeight(node: node.left) - getHeight(node: node.right))
    }
    
    //判断树是否为平衡二叉树
    func isBalanced() -> Bool {
        return isBalanced(node: root)
    }
    
    private func isBalanced(node: AVLTreeNode?) -> Bool {
        guard let node = node else {
            return true
        }
        
        let balanceFactory = getBalanceFactor(node: node)
        if balanceFactory > 1 {
            return false
        }
        return isBalanced(node: node.left) && isBalanced(node: node.right)
    }
    
    /**
     * 右旋转,返回根节点
     */
    private func rightRotate(y: AVLTreeNode?) -> AVLTreeNode? {
        guard let y = y else {
            return nil
        }
        let x = y.left
        let t3 = x?.right
        x?.right = y
        y.left = t3
        //更新height
        y.height = max(getHeight(node: y.left),getHeight(node: y.right))+1
        x?.height = max(getHeight(node: x?.left),getHeight(node: x?.right))+1
        return x
    }
    
    /**
     * 左旋转
     */
    private func leftRotate(y: AVLTreeNode?) -> AVLTreeNode? {
        guard let y = y else {
            return nil
        }
        let x = y.right
        let t3 = x?.left
        x?.left = y
        y.right = t3
        //更新height
        y.height = max(getHeight(node: y.left),getHeight(node: y.right)) + 1
        x?.height = max(getHeight(node: x?.left),getHeight(node: x?.right)) + 1
        return x
    }
    
    // 向二分搜索树中添加新的元素(key, value)
    func add(value: T) {
        root = add(node: root, value: value)
    }
    
    // 向以node为根的二分搜索树中插入元素(key, value)，递归算法
    // 返回插入新节点后二分搜索树的根
    private func add(node: AVLTreeNode?, value: T) -> AVLTreeNode? {
        guard let node = node else {
             size += 1
            return AVLTreeNode(value: value)
        }

        //判断是插入根节点的左子树还是右子树
        if value < node.value {
            node.left = add(node: node.left, value: value)
        } else if value > node.value {
            node.right = add(node: node.right, value: value)
        }
        
        //更新height
        node.height = 1 + max(getHeight(node: node.left),getHeight(node: node.right))
        
        //计算平衡因子
        let balanceFactor = getBalanceFactor(node: node)
        if balanceFactor > 1 && getBalanceFactor(node: node.left) > 0 {
            //右旋LL
            return rightRotate(y: node)
        }
        if balanceFactor < -1 && getBalanceFactor(node: node.right) < 0  {
            //左旋RR
            return leftRotate(y: node)
        }
        
        //LR
        if balanceFactor > 1 && getBalanceFactor(node: node.left) < 0 {
            node.left = leftRotate(y: node.left)
            return rightRotate(y: node)
        }
        
        //RL
        if balanceFactor < -1 && getBalanceFactor(node: node.right) > 0 {
            node.right = rightRotate(y: node.right)
            return leftRotate(y: node)
        }
        return node
    }

}

extension AvlTree {
    //查找二叉搜索树的节点
    private func getNode(root: AVLTreeNode?, value: T) -> AVLTreeNode? {
        guard let root = root else {
            return nil
        }
        
        if(root.value == value) {
            return root
        } else if value > root.value {
            return getNode(root: root.right, value: value)
        } else {
            return getNode(root: root.left, value: value)
        }

    }
    //移出节点
    func remove(value: T) -> T? {
        guard let node = getNode(root: root, value: value) else {
            return nil
        }
        root = remove(node: root, value: value)
        return node.value
    }
    
    //二叉搜索树的最小值一直找左孩子就行了
    private func minNode(node: AVLTreeNode?) -> AVLTreeNode? {
        guard let node = node else {
            return nil
        }
        
        if let node = node.left {
            return minNode(node: node.left)
        } else {
            return node
        }
    }

    private func remove(node: AVLTreeNode?, value: T) -> AVLTreeNode? {
        guard let node = node else {
            return nil
        }
        var retNode: AVLTreeNode?
        if value < node.value {
            node.left = remove(node: node.left , value: value)
            retNode = node
        } else if value > node.value {
            node.right = remove(node: node.right, value: value)
            retNode = node
        } else {
            // 待删除节点左子树为空的情况
            if node.left == nil {
                let rightNode = node.right
                node.right = nil
                size -= 1
                retNode = rightNode
            } else if node.right == nil {
                // 待删除节点右子树为空的情况
                let leftNode = node.left
                node.left = nil
                size -= 1
                retNode = leftNode
            } else {
                // 待删除节点左右子树均不为空的情况
                // 找到比待删除节点大的最小节点, 即待删除节点右子树的最小节点
                // 用这个节点顶替待删除节点的位置
                let successor = minNode(node: node.right)!
                successor.right = remove(node: node.right, value: successor.value)
                successor.left = node.left

                node.left = nil
                node.right = nil
                retNode = successor
            }
        }
        
        guard let retNodeTmp = retNode else {
            return nil
        }
        //维护平衡
        //更新height
        retNodeTmp.height = 1 + max(getHeight(node: retNodeTmp.left),getHeight(node: retNodeTmp.right))
        
        //计算平衡因子
        let balanceFactor = getBalanceFactor(node: retNodeTmp)
        if balanceFactor > 1 && getBalanceFactor(node: retNodeTmp.left) >= 0 {
            //右旋LL
            return rightRotate(y: retNodeTmp)
        }
        
        if balanceFactor < -1 && getBalanceFactor(node: retNodeTmp.right) <= 0 {
            //左旋RR
            return leftRotate(y: retNodeTmp)
        }
        
        //LR
        if balanceFactor > 1 && getBalanceFactor(node: retNodeTmp.left) < 0 {
            node.left = leftRotate(y: retNodeTmp.left)
            return rightRotate(y: retNodeTmp)
        }
        
        //RL
        if balanceFactor < -1 && getBalanceFactor(node: retNodeTmp.right) > 0 {
            node.right = rightRotate(y: retNodeTmp.right)
            return leftRotate(y: retNodeTmp)
        }
        return retNodeTmp
    }
}
