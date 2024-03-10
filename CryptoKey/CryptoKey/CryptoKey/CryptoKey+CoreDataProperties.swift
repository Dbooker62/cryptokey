//
//  CryptoKey+CoreDataProperties.swift
//  CryptoKey
//
//  Created by Zaid's Mac on 09/03/2024.
//
//

import Foundation
import CoreData


extension CryptoKey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoKey> {
        return NSFetchRequest<CryptoKey>(entityName: "CryptoKey")
    }

    @NSManaged public var key1: String?

}

extension CryptoKey : Identifiable {

}
