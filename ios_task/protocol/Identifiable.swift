//
//  Identifiable.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import UIKit

extension Identifiable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: Identifiable {}
