//
//  HashTable哈希表.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit

class HashTables: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) var count = 0
    var isEmpty: Bool { return count == 0 }
    
    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }
    
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    func value(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    
    @discardableResult
    mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    @discardableResult
    mutating func removeValue(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        return nil
    }
}

private extension HashTable {
    func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
}
