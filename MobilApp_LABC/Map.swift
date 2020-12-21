//
//  Map.swift
//  MobilApp_LABC
//
//  Created by Carl-Bernhard Hallberg on 2020-12-21.
//

import SwiftUI

struct Map: View {
    var body: some View {
        MapView()
            .ignoresSafeArea()
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}
