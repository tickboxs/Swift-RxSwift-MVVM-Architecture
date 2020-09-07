//
//  HttpResponse.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Jsonable {
    init(json: JSON)
}

extension Array: Jsonable where Element: Jsonable {
    init(json: JSON) {
        self = json.array?.map { Element(json: $0) } ?? []
    }
    
}

struct HttpResponse<T: Jsonable>: Error {
    
    var code: HttpCode?
    var data: T?
    var errorMessage: String?
}

// Replacement for Void because Void tpye cannot conform to Jsonable Protocol
struct VOID: Jsonable {
    init(json: JSON) { }
}

extension HttpResponse: Jsonable {
    
    init(json: JSON) {
        self.code         = json["code"].int?.toHttpCode()
        self.data         = T(json: json["data"])
        self.errorMessage = json["errorMessage"].string
    }
    
}
