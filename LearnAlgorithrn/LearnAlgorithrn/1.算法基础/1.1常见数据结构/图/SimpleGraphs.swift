//
//  SimpleGraphs.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/23.
//

import UIKit

class SimpleGraphs: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

struct SimpleVertex{
    let index: Int///顶点被添加到图中的先后顺序
    let value: Int///顶点所包含的值
}

struct SimpleGraph {
    var vertexs: [SimpleVertex] = [SimpleVertex]()
    var edges: [[Int]] = [[Int]]()
}

///邻接表
// 图顶点
struct AdjVertex: Hashable {
    var value: String?
    var index: Int?
}
struct AdjEdge: Hashable{
    var begin: AdjVertex?///边的起点
    var end: AdjVertex?///边的终点
    var weight: Int?///边的权重
}
// 图
struct AdjGraph {
    var adjList: [AdjVertex: [AdjEdge]] = [:]///定义字典,顶点为key,数组为value
}

///https://juejin.cn/post/6844903856510337031

struct SearchSort {
    // 存储已访问的顶点
    var visited: [String] = []

    func visit(_ v: String) {
        print(v)
    }

    ///广度优先遍历
    ///广度优先遍历类似于树的层序遍历。递归即可
    ///从 A 开始，找到所有自己一步能到达的顶点（B，C）加入队列，查找是否是自己需要的（G），如果不是，再将这些顶点（B，C）一步能到达的顶点（D，E），加入到队列中。如果找到，直接返回结果，否则就这样一层一层的找下去，直至队列为空。

//    mutating func breadthFirstSearch(_ value: String?) {
//        // 利用数组表示队列
//        var queue = [String]()
//
//        if let vertex = value {
//            queue.insert(vertex, at: 0)
//        }
//
//        while queue.count != 0 {
//            let current = queue.popLast()!
//
//            if !visited.contains(current) {
//                visit(current)
//                visited.append(current)
//            }
//
//            guard let neighbors = graph[current] else {
//                continue
//            }
//
//            for data in neighbors {
//                if !visited.contains(data) {
//                    queue.insert(data, at: 0)
//                }
//            }
//        }
//    }
//    // 深度优先遍历
//    从某个顶点（A）出发，访问顶点并标记为已访问。
//    访问 A 的其中一个邻接点（假设为 B），如果没有访问过，访问该顶点并标记为已访问。
//    然后再访问该顶点（B）的邻接点（D），重复上述步骤。
//    mutating func depthFirstSearch(_ value: String?) {
//        guard let vertex = value else {
//            return
//        }
//
//        visit(vertex)
//        visited.append(vertex)
//
//        guard let neighbors = graph[vertex] else {
//            return
//        }
//
//        for data in neighbors {
//            if !visited.contains(data) {
//                depthFirstSearch(data)
//            }
//        }
//    }


}
