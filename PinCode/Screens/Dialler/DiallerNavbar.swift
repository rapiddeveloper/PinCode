//
//  DiallerNavbar.swift
//  BankManager
//
//  Created by Admin on 2/2/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import SwiftUI

struct DiallerNavbar: View {
    var body: some View {
        HStack {
            Image("jennifer")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Jennifer Nwanchukwu")
                    .font(.headline)
                Text("jen@gmail.com")
                    .font(.callout)
                    .foregroundColor(Color(UIColor.gray))
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Not me")
            }
        }
    }
}

struct DiallerNavbar_Previews: PreviewProvider {
    static var previews: some View {
        DiallerNavbar()
    }
}
