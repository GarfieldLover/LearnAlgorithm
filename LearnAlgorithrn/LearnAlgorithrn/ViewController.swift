//
//  ViewController.swift
//  LearnAlgorithrn
//
//  Created by 狄烨 . on 2022/2/21.
//

import UIKit
import SwiftyForm
import SnapKit
struct Sort { }

public func StartTime() ->TimeInterval {
    return Date().timeIntervalSince1970*1000
}

public func EndTime() ->TimeInterval {
    return Date().timeIntervalSince1970*1000
}

public func ConsumeTime(_ startTime: TimeInterval) {
    print("代码执行时长\(EndTime()-startTime)毫秒")
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

    }
}

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        tableView.estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.delaysContentTouches = true
        return tableView
    }()
    
    lazy var former = Former(tableView: tableView)
    
    lazy var s1 : SectionFormer = {
        let section = SectionFormer()
        let header = LabelHeaderFooter()
        header.viewHeight = 20
        header.title = "常见排序算法"
        section.set(headerViewFormer: header)
        return section
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        s1.add(rowFormers: [createRow(InsertionSort(),"插入排序"),
                            createRow(SelectionSort(),"选择排序"),
                            createRow(BubbleSort(),"冒泡排序"),
                            createRow(ShellSort(),"希尔排序")])
        former.append(sectionFormer: s1)
    }

    func createRow(_ vc: UIViewController, _ name: String) -> LabelRow{
        let labelRow = LabelRow()
        labelRow.title = name
        labelRow.cell.accessoryType = .disclosureIndicator
        labelRow.onSelected { (row) in
            self.present(vc, animated: true, completion: nil)
        }
        return labelRow
    }
}

