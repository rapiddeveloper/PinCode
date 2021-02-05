//
//  AppData.swift
//  BankManager
//
//  Created by Admin on 1/27/21.
//  Copyright © 2021 rapid interactive. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct Transaction: Codable {
     
    var imageName: String?
    var title: String
    var cardType: CardType
    var cardLastDigits: Int
    var direction: Direction
    var amount: Double
    
    enum Direction: String, Hashable, Codable {
        case recieved = "recieved"
        case sent = "sent"
    }
    
    enum CardType: String, Hashable, Codable {
        case visa = "Visa"
        case master = "Master"
    }
}

struct TransactionsByDayModel: Codable {
    var date: String
    var transactions: [Transaction]
}

struct TransactionViewModel: Codable, Identifiable {
    
    var transaction: Transaction
    var id = UUID()
    
    var amount: String {
           let formatter = NumberFormatter()
           formatter.locale = Locale(identifier: "en_NG")
           formatter.numberStyle = .currency
           formatter.maximumFractionDigits = 2
           
           let number = NSNumber(value: transaction.amount)
           return formatter.string(from: number) ?? "--"
       }
    
    var name: String {
          transaction.title.capitalized
      }
      
      var cardPin: String {
          String(transaction.cardLastDigits)
      }
      
      var cardCategory: String {
          transaction.cardType.rawValue.capitalized
      }
      
      var imageName: String {
          transaction.imageName ?? cardCategory.lowercased()
      }
      
      var category: String {
          transaction.direction.rawValue.capitalized
      }
      
      var arrow: String {
                transaction.direction == .recieved ? "arrow.left" : "arrow.right"
       }
           
      var categorySymbol: String {
           transaction.direction == .recieved ? "+" : "-"
      }
      
      var transactionImage: some View {
             
             guard let imageName =  transaction.imageName else {
                 return AnyView (
                      PlaceHolder(cardCategory: transaction.cardType)
                 )
             }
             
             return AnyView (
                 Image(imageName)
                     .resizable()
                     .frame(width: 48.0, height: 48.0)
                     .cornerRadius(12)
                 
             )
         }
      
      var transactionColor: Color {
         transaction.direction == .recieved ?
              Color("recieved") :
              Color("sent")
      }
}

struct TransactionsByDayViewModel: Identifiable {
     
    var transactionsByDay: TransactionsByDayModel
    var id = UUID()
    var dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    var title: String {
        
        dateFormatter.dateFormat = "dd/M/yy"
        
        guard let date = dateFormatter.date(from: transactionsByDay.date) else {
            return "Date Not Available"
        }
        
        let components = calendar.dateComponents([.day, .month], from: date)
        
     //   var title = ""
        
        let day = components.day!
        let month = components.month!
        let monthSymbol = dateFormatter.monthSymbols![month - 1]
        
        return "\(monthSymbol) \(day)"
        
    }
    
    var list: [TransactionViewModel] {
        transactionsByDay.transactions.map({TransactionViewModel(transaction: $0)})
    }
    
}

struct Profile: Codable {
    var username: String
    var imageName: String
}

struct Goal: Codable {
    var name: String
    var target: Double
    var current: Double
}

struct Budget: Codable {
    var name: String
    var leftover: Double
    var imageName: String
}

struct PlanInfo: Codable {
    var name: String
    var amount: Double
}

struct FinancePlan: Codable {
    var info: [PlanInfo]
    var goals: [Goal]
    var budgets: [Budget]
}

struct UserData: Codable {
    var profile: Profile
    var history: [TransactionsByDayModel]
    var plan: FinancePlan
}

final class AppData: ObservableObject {
    
    let fileManager: FileManager
    @Published var monthlyTransactions = [TransactionsByDayViewModel]()
    @Published var userData: UserData? = nil
    
    init() {
        fileManager = FileManager.default
        monthlyTransactions = loadTransactions().map({TransactionsByDayViewModel(transactionsByDay: $0)})
        if let userData = loadUserData() {
            self.userData = userData
            print(userData)
        }
        
    }
    
    func loadTransactions() -> [TransactionsByDayModel] {
         
        let bundle = Bundle.main
        
        guard let filePath = bundle.path(forResource: "HistoryData", ofType: "json") else {return []}
        
        guard let data = fileManager.contents(atPath: filePath) else { return [] }
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([TransactionsByDayModel].self, from: data)
            return result
        } catch {
            fatalError("Can't read date: \(error)")
        }
        
    }
    
    func loadUserData() -> UserData? {
         
        let bundle = Bundle.main
        
        guard let filePath = bundle.path(forResource: "userData", ofType: "json") else {return nil}
        
        guard let data = fileManager.contents(atPath: filePath) else { return nil }
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(UserData.self, from: data)
            return result
        } catch {
            fatalError("Can't read date: \(error)")
        }
        
    }
    
 
    
    
}
