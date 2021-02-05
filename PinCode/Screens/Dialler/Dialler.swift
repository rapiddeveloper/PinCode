//
//  Dialler.swift
//  BankManager
//
//  Created by Admin on 2/2/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import SwiftUI

class DiallerData: ObservableObject {
    
    
    @Published var pin = ["", "", "", ""]
    var delCount = 0
    var pinInputCount = 0
    func updatePin(_ pinInput: String) {
        
        if  pinInput.contains("face") {return}
        
        if Int(pinInput) != nil, let idx = pin.firstIndex(where: {$0 == ""}) {
             pin[idx] = pinInput
        }
        
        if pinInput.contains("del"), let idx = pin.lastIndex(where: {$0 != ""}) {
               pin[idx] = ""
        }
    }
}

struct Dialler: View {
    
    @ObservedObject var diallerData = DiallerData()
    
    var body: some View {
        VStack {
            DiallerNavbar()
            Spacer()
            PinCodeIndicator(diallerData: diallerData)
            Spacer()
            DiallerButtons(width: 80, height: 80, spacing: 32, diallerData: diallerData)
            Spacer()
            Button("Forgot Code?", action: {})
            Spacer()
           
        }
        .padding([.top, .trailing, .leading])
        .navigationBarHidden(true)
        .navigationBarTitle("")
         
    }
}

struct Dialler_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Dialler()
        }
       
    }
}
