////
////  IntrinsicTableView.swift
////  GrubChill
////
////  Created by Bharath Kumar on 29/11/20.
////
//
//import Foundation
//
//class IntrinsicTableView: UITableView {
//
//    override var contentSize:CGSize {
//        didSet {
//            self.invalidateIntrinsicContentSize()
//        }
//    }
//
//    override var intrinsicContentSize: CGSize {
//        self.layoutIfNeeded()
//        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
//    }
//
//    override func endUpdates() {
//        super.endUpdates()
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func reloadData() {
//        super.reloadData()
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
//        super.reloadRows(at: indexPaths, with: animation)
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
//        super.reloadSections(sections, with: animation)
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
//        super.insertRows(at: indexPaths, with: animation)
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
//        super.insertSections(sections, with: animation)
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
//        super.deleteRows(at: indexPaths, with: animation)
//        self.invalidateIntrinsicContentSize()
//    }
//
//    override func deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
//        super.deleteSections(sections, with: animation)
//        self.invalidateIntrinsicContentSize()
//    }
//  
//}
