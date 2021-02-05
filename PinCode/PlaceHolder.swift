//
//  PlaceHolder.swift
//  BankManager
//
//  Created by Admin on 1/29/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import SwiftUI

struct PlaceHolder: View {
    
   let cardCategory: Transaction.CardType
        
       var body: some View {
           
           VStack {
               Image(cardCategory.rawValue.lowercased())
                   .resizable()
                   .frame(width: 24, height: 16)
                   .padding()
           }
           .frame(width: 48.0, height: 48.0)
           .background(
              RoundedRectangle(cornerRadius: 12)
                  .fill(Color(UIColor.systemGray5))
           )
          
               
       }
}

struct PlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceHolder(cardCategory: .master)
    }
}
