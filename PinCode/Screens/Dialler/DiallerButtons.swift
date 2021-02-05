//
//  DiallerButtons.swift
//  BankManager
//
//  Created by Admin on 2/2/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import SwiftUI
import Combine

struct DiallerButtons: View {
    
    let width: CGFloat
    let height: CGFloat
    let spacing: CGFloat
    var input = ""
   
    @ObservedObject var diallerData: DiallerData
    @State private var pinInput = ""
//    private var pinInput: Binding<String> {
//        Binding(get: {
//            self.pinInput.wrappedValue
//        }, set: {
//            self.pinInput.wrappedValue = $0
//            self.diallerData.pin.append($0)
//        })
//    }
    
 
    
    
    var body: some View {
       
        VStack(spacing: 16) {
          
            HStack(spacing: spacing) {
                ForEach(["1", "2", "3"], id: \.self) { num in
                    DiallerButton(num: num, width: self.width, height: self.height, text: self.$pinInput.onUpdate {
                        self.diallerData.updatePin(self.pinInput)
                    })
                    
                }
            }
            
            HStack(spacing: spacing) {
                ForEach(["4", "5", "6"], id: \.self) { num in
                    DiallerButton(num: num, width: self.width, height: self.height, text: self.$pinInput.onUpdate {
                          self.diallerData.updatePin(self.pinInput)
                    })
                }
            }
            HStack(spacing: spacing) {
                ForEach(["7", "8", "9"], id: \.self) { num in
                    DiallerButton(num: num, width: self.width, height: self.height, text: self.$pinInput.onUpdate {
                         self.diallerData.updatePin(self.pinInput)
                    })
                }
            }
            HStack(spacing: spacing) {
                ForEach(["faceid", "0", "delete.left.fill"], id: \.self) { num in
                    DiallerButton(num: num, width: self.width, height: self.height, text: self.$pinInput.onUpdate {
                         self.diallerData.updatePin(self.pinInput)
                    })
                }
            }
        }
    }
}

extension Binding {
    
    /// When the `Binding`'s `wrappedValue` changes, the given closure is executed.
    /// - Parameter closure: Chunk of code to execute whenever the value changes.
    /// - Returns: New `Binding`.
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            self.wrappedValue
        }, set: { newValue in
            self.wrappedValue = newValue
            closure()
        })
    }
}

struct DiallerButtons_Previews: PreviewProvider {
    static var previews: some View {
        DiallerButtons(width: 80, height: 80, spacing: 32, diallerData: DiallerData())
    }
}
