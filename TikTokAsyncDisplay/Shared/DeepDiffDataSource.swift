//
//  DeepDiffDataSource.swift
//  TikTokAsyncDisplay
//
//  Created by RX on 8/2/23.
//

import Foundation

class DeepDiffDataSource<T>: NSObject {
    var data: DeepDiffDynamicValue<[T]> = DeepDiffDynamicValue([])
    func getCount() -> Int {
        return data.value.count
    }
    func value(atIndex index: Int) -> T {
        return data.value[index]
    }
    func append(items: T) {
        data.value.append(items)
    }
}

class DeepDiffDynamicValue<T> {
    
    fileprivate var value: T
    typealias DeepDiffCompletionHandler = (T, T, (() -> Void)?) -> Void
    private var observers = [String: DeepDiffCompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping DeepDiffCompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func updateDiff(old: T, new: T, completion: (() -> Void)? = nil) {
        value = new
        observers.forEach({ $0.value(old, new, completion) })
    }
    
    public func getValues() -> T {
        return value
    }
    
    deinit {
        observers.removeAll()
    }
    
}
