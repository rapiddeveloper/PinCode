//
//  PinCodeIndicator.swift
//  BankManager
//
//  Created by Admin on 2/2/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import SwiftUI

struct PinCodeIndicator: View {
    
    @ObservedObject var diallerData: DiallerData
    
    var body: some View {
        HStack(spacing: 24) {
            ForEach(diallerData.pin, id: \.self) { item in
                Circle()
                    .fill(item == "" ? Color.gray : Color.blue)
                    .frame(width: 16, height: 16)
            }
        }
    }
}

struct PinCodeIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeIndicator(diallerData: DiallerData())
    }
}
