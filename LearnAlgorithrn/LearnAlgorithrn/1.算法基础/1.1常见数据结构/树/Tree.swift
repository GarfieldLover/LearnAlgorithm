//
//  Tree树.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Tree: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

///一个节点可以包含多个子节点，因此子节点是一个数组类型
class TreeNode<T> {
    weak var parent: TreeNode?
    var value: T
    var children: [TreeNode] = []
    
    init(_ value: T) {
        self.value = value
    }
}
extension TreeNode {
    
    func add(_ child: TreeNode) {
        children.append(child)
    }
    
    // 按照深度遍历，先遍历自己，再遍历子节点
    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach(visit)
    }
    // 按照层级，先遍历上层，再依次向下遍历
    func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        var queue = Queue<TreeNode>()
        children.forEach{ queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach({ queue.enqueue($0)})
        }
    }
}

extension TreeNode where T : Equatable {
    func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }
        return result
    }
}



