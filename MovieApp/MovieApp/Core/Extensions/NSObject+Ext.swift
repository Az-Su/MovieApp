//
//  NSObject+Ext.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 08.02.2023.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
