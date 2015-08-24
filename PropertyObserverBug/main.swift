//
//  main.swift
//  propertyObserverBug
//
//  Created by James Pamplona on 8/23/15.
//  Copyright © 2015 James Pamplona. All rights reserved.
//

import Foundation

protocol HasProperty {
    var property: String { get set }
}

struct Foo: HasProperty {
    var property = "value"
}

class Bar: HasProperty {
    var property = "value"
}

// An array of structs. When a property of one of it's elements is changed, the property observer IS triggered, which is unexpected behavior, in my opinion.
var structs = [Foo(), Foo(), Foo()] {
    didSet {
        print("👎🏼 The struct array property observer was triggered -- although the array was not set.")
    }
}

// An array of classes. When a property of one of it's elements is changed, the property observer is NOT triggered, which is correct behavior, in my opinion, as the array itself was not assigned to.
var classes = [Bar(), Bar(), Bar()] {
    didSet {
        print("This correctly does not get triggered when assigning to one of it's element's properties")
    }
}

// An array of instances which conform to a protocol. When a property of one of it's elements IS changed, the property observer is triggered, which is unexpected behavior, in my opinion.
var protocols: [HasProperty] = [Bar(), Bar(), Bar()] {
    didSet {
        print("👎🏼 The protocols array property observer was triggered -- although the array was not set.")
    }
}

// This DOES trigger the array property observer --Incorrect and confusing behavior 👎🏼
structs[0].property = "newValue"

// This does NOT trigger the array property observer --The correct behavior         👍🏼
classes[0].property = "newValue"

// This DOES trigger the array property observer --Incorrect and confusing behavior 👎🏼
protocols[0].property = "newValue"