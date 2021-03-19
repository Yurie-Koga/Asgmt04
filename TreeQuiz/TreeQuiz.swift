//
//  TreeQuiz.swift
//  TreeQuiz
//
//  Created by Uji Saori on 2021-03-19.
//

import Foundation

func parentNode() {
    let n = Int(readLine()!)!
    var tree = [[Int]](repeating: [Int](), count: n + 1)    // skip index 0 to make readable
    
    for _ in 0 ..< n - 1 {
        let nodes = readLine()!.split(separator: " ").map { String($0) }
        tree[Int(nodes[0])!].append(Int(nodes[1])!)
        tree[Int(nodes[1])!].append(Int(nodes[0])!)
    }
    
//    print("===== Each Node =====")
//    for i in 1 ... n {
//        print("<\(i)> \(tree[i])")
//    }
    
    print("===== Parent Node =====")
    for i in 2 ... n {
        print(tree[i][0])
    }
}


func diameter() {
    let n = Int(readLine()!)!
    var tree = [[[Int]]](repeating: [[Int]](), count: n + 1)    // skip index 0 to make readable
    
    for _ in 0 ..< n {
        let nodeInfo = readLine()!.split(separator: " ").map { String($0) }
        let node = Int(nodeInfo[0])!
        for i in 1 ..< nodeInfo.count - 1 where i % 2 != 0 {
            tree[node].append([Int(nodeInfo[i])!, Int(nodeInfo[i + 1])!])
        }
    }
    
//    print("===== Each Node =====")
//    for i in 1 ... n {
//        print("<\(i)> \(tree[i])")
//    }
    
    print("===== Diameter =====")
    var dis = 0
    var max = 0
    for i in 1 ... n {
        if tree[i].count > 1 { continue }
//        print("<\(i)> \(tree[i])")
        nodeDis(tree: tree, stNodeIndex: i, preNodeIndex: 0, disSofar: &dis, maxDis: &max)
    }
    print(max)
}

func nodeDis(tree: [[[Int]]], stNodeIndex: Int, preNodeIndex: Int, disSofar: inout Int, maxDis: inout Int) {
    let curNodes = tree[stNodeIndex]
    for i in 0 ..< curNodes.count {
        let connectedNode = curNodes[i][0]
        if connectedNode != preNodeIndex {
            disSofar += curNodes[i][1]
            nodeDis(tree: tree, stNodeIndex: connectedNode, preNodeIndex: stNodeIndex, disSofar: &disSofar, maxDis: &maxDis)
//            print("end of nodes: \(disSofar)")
            if maxDis < disSofar { maxDis = disSofar }
            disSofar -= curNodes[i][1]
        }
    }
}

