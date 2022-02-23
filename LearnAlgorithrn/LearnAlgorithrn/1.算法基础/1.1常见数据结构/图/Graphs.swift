//
//  Graph图.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class Graphs: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///https://www.jianshu.com/p/0d0d4acdafb5
        ///https://juejin.cn/post/6844903856510337031
        ///邻接表
        let graph = AdjacencyList<String>()

        let wuHan = graph.createVertex(value: "武汉")
        let shangHai = graph.createVertex(value: "上海")
        let shenZhen = graph.createVertex(value: "深圳")
        let beiJing = graph.createVertex(value: "北京")
        let hongKong = graph.createVertex(value: "香港")
        let newYork = graph.createVertex(value: "纽约")

        graph.addEdge(.undirected, from: wuHan, to: shangHai, weight: 300)
        graph.addEdge(.undirected, from: wuHan, to: shenZhen, weight: 500)
        graph.addEdge(.undirected, from: shangHai, to: shenZhen, weight: 700)
        graph.addEdge(.undirected, from: shangHai, to: beiJing, weight: 600)
        graph.addEdge(.undirected, from: shenZhen, to: beiJing, weight: 1000)
        graph.addEdge(.undirected, from: shenZhen, to: hongKong, weight: 200)
        graph.addEdge(.undirected, from: beiJing, to: newYork, weight: 6000)
        graph.addEdge(.undirected, from: hongKong, to: newYork, weight: 5000)

        print(graph)
        
        
        // 结果
//        4: 香港 --> [ 2: 深圳, 5: 纽约 ]
//        5: 纽约 --> [ 3: 北京, 4: 香港 ]
//        2: 深圳 --> [ 0: 武汉, 1: 上海, 3: 北京, 4: 香港 ]
//        0: 武汉 --> [ 1: 上海, 2: 深圳 ]
//        1: 上海 --> [ 0: 武汉, 2: 深圳, 3: 北京 ]
//        3: 北京 --> [ 1: 上海, 2: 深圳, 5: 纽约 ]
        
        ///邻接矩阵
        let graph1 = AdjacencyMatrix<String>()

        let wuHan1 = graph1.createVertex(value: "武汉")
        let shangHai1 = graph1.createVertex(value: "上海")
        let shenZhen1 = graph1.createVertex(value: "深圳")
        let beiJing1 = graph1.createVertex(value: "北京")

        graph1.addDirectedEdge(from: wuHan1, to: shangHai1, weight: 300)
        graph1.addDirectedEdge(from: wuHan1, to: shenZhen1, weight: 500)
        graph1.addDirectedEdge(from: shangHai1, to: beiJing1, weight: 600)
        graph1.addDirectedEdge(from: shenZhen1, to: shangHai1, weight: 700)
        graph1.addUndirectedEdge(between: shenZhen1, and: beiJing1, weight: 1000)

        print(graph1)
        
        
    }

}
///V 是图中点的数量，E 是边数
///定义点
struct Vertex<T>{
    let index: Int///顶点被添加到图中的先后顺序
    let value: T///顶点所包含的值
}

extension Vertex: Hashable {
    var hashValue: Int {
        return index.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
    
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.index == rhs.index
    }
}
///打印
extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(index): \(value)"
    }
}
///Edge对象始终是有向的，单向连接
///定义边
struct Edge<T> {
    let source: Vertex<T>///边的起点
    let destination: Vertex<T>///边的终点
    let weight: Int?///边的权重
}

///Graph 协议   图的实现方式有两种：邻接表和邻接矩阵
enum EdgeType {
    case directed//有向
    case undirected//无向
}

protocol Graph {
    associatedtype Element
    
    // 创建顶点
    func createVertex(value: Element) -> Vertex<Element>
    
    // 在两个顶点中添加有向的边
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Int?)
    
    // 在两个顶点中添加无向的边
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Int?)
    
    // 根据边的类型在两个顶点中添加边
    func addEdge(_ edge: EdgeType,
                 from source: Vertex<Element>,
                 to destination: Vertex<Element>,
                 weight: Int?)
    
    // 返回从某个顶点发出去的所有边
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    
    // 返回从一个顶点到另个顶点的边的权重
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Int?
}
extension Graph {
    // 在两个顶点中添加无向的边，也就相当于在两个顶点之间互相添加有向图
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Int?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    // 根据边的类型在两个顶点中添加边，可以直接根据边的类型调用协议里的其他方法来实现
    func addEdge(_ edge: EdgeType,
                 from source: Vertex<Element>,
                 to destination: Vertex<Element>,
                 weight: Int?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}
///邻接表
final class AdjacencyList<T> {
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]///定义字典,顶点为key,数组为value
    init() { }
}
extension AdjacencyList: Graph {

    func createVertex(value: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, value: value)
        adjacencies[vertex] = []
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Int?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjacencies[source] ?? []
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Int? {
        return edges(from: source)
            .first { $0.destination == destination }?
            .weight
    }
    
}

extension AdjacencyList: CustomStringConvertible {
    var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index < edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) --> [ \(edgeString) ]\n")
        }
        return result
    }
}

////////////////////////邻接矩阵////////////////////////
//表格形式.左边顶点前面的数字代表顶点被加入图时的位置，右边行号表示出发点，列号表示终点
final class AdjacencyMatrix<T> {
    private var vertices: [Vertex<T>] = []///所有的顶点
    private var weights: [[Int?]] = []///所有边的权重
    init() { }
}

extension AdjacencyMatrix: Graph {

    func createVertex(value: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, value: value)
        vertices.append(vertex)
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        let row = [Int?](repeating: nil, count: vertices.count)
        weights.append(row)
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Int?) {
        weights[source.index][destination.index] = weight
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            guard let weight = weights[source.index][column] else {
                continue
            }
            let edge = Edge(source: source,
                            destination: vertices[column],
                            weight: weight)
            edges.append(edge)
        }
        return edges
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Int? {
        return weights[source.index][destination.index]
    }
    
}
extension AdjacencyMatrix: CustomStringConvertible {
    var description: String {
        let verticesDes = vertices.map { "\($0)" }
                          .joined(separator: "\n")
        var grid: [String] = []
        for i in 0..<weights.count {
            var row = ""
            for j in 0..<weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDes = grid.joined(separator: "\n")
        return "\(verticesDes)\n\n\(edgesDes)"
    }
}
