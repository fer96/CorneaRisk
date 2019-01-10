//
//  Ecuations.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import Foundation


class Ecuations{
    func cholesterolMgDlToMol(oldCholesterol: Double) -> Double {
        return oldCholesterol * 0.02586
    }
    func cholesterolMolToMgDl(oldCholesterol: Double) -> Double {
        return oldCholesterol * 38.67
    }
}
