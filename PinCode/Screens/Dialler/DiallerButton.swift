//
//  DiallerButton.swift
//  BankManager
//
//  Created by Admin on 2/2/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import SwiftUI

struct DiallerButtonModifier: ViewModifier {
    
    let label: String
    
    func body(content: Content) -> some View {
    
        if Int(label) != nil {
            return  AnyView (
                     content
                        .foregroundColor(Color(UIColor.label))
                        .background(Circle().fill(Color(UIColor.systemGray6)))
                        
            )
        } else if label.contains("delete") {
            return  AnyView (
                content
                    .foregroundColor((Color("secondary")))
                    .overlay(
                        Image(systemName: "xmark")
                            .font(Font.system(.subheadline).weight(.semibold))
                            .foregroundColor(Color(UIColor.label))
                            .offset(x: 4, y: -7)
                )

            )
        } else {
            return AnyView(
                        content
                            .foregroundColor(.black)
                   )
        }
    }
    
}

struct DiallerButton: View {
    
    let num: String
    let phoneChars = [
                    "1": "", "2":"ABC", "3":"DEF",
                   "4":"GHI", "5":"JKL", "6":"MNO",
                   "7":"PQRS","8":"TUV","9":"WXYZ",
                   "faceid":"", "0":"", "delete.left.fill":""
                    ]
   let width: CGFloat
   let height: CGFloat
   @Binding var text: String
    
    var body: some View {
        Button(action: {
            self.text = self.num
        }, label: {
         VStack {
           getLabel()
            .font(.largeTitle)
            Text(phoneChars[num]!)
                .font(.subheadline)
                .fontWeight(.semibold)
                .kerning(2.0)
            }
            .frame(width: width, height: height)
            .modifier(DiallerButtonModifier(label: num))
          }
          
        )
       
     }
    
    func getLabel() -> AnyView {
         Int(num) == nil ?
            AnyView( Image(systemName: num) ) :
            AnyView( Text(num))
    }
}

struct DiallerButton_Previews: PreviewProvider {
    static var previews: some View {
        DiallerButton(num: " 1", width: 100.0, height: 100.0, text: .constant(""))
    }
}
