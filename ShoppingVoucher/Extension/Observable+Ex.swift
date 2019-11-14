//
//  Observable+Ex.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift
import RxCocoa

protocol OptionalType {
    associatedtype Wrapped
    
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? {
        return self
    }
}

extension Observable where Element: OptionalType {
    func filterEmpty() -> Observable<Element.Wrapped> {
        return flatMap { e -> Observable<Element.Wrapped> in
            if let value = e.value {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }
}

extension Observable where Element: Equatable {
    
    func ignore(value: Element) -> Observable<Element> {
        return filter { e -> Bool in
            return value != e
        }
    }
}


extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
           return catchError { _ in
               return Observable.empty()
           }
       }

       func asDriverOnErrorJustComplete() -> Driver<Element> {
           return asDriver { error in
               assertionFailure("Error \(error)")
               return Driver.empty()
           }
       }

       func mapToVoid() -> Observable<Void> {
           return map { _ in }
       }
}
