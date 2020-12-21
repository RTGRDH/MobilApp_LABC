//
//  Controller.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation
import CoordinateTransformationLibrary

func test() -> Void{
    let pos = SWEREF99Position(n: 6580534.000011, e: 150531.999244, projection: SWEREF99Position.SWEREF99Projection.sweref_99_18_00)
    let x = pos.toWGS84()
    print(x)
}
