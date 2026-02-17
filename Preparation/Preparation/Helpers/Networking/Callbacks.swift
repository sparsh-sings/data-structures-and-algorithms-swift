//
//  Callbacks.swift
//  Preparation
//
//  Created by Sparsh Singh on 16/02/26.
//

final class Callbacks<T, V> {
    
    private let successBlock : T -> Void
    private let failureBlock : V -> Void
    
    private init(successBlock: T, failureBlock: V) {
        self.successBlock = successBlock
        self.failureBlock = failureBlock
    }
    
    func onSuccess(_ successResponse : T) {
        successBlock(successResponse)
    }
    
    func onFailure(_ failureResponse : V) {
        failureBlock(failureResponse)
    }
    
}
