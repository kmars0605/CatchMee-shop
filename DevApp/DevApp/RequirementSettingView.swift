//
//  RequirementSettingView.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/27.
//

import SwiftUI
import Firebase

struct RequirementSettingView: View {
    @StateObject var viewModel = RequirementSettingViewModel()
    // 募集人数
    @State var numberOfPeople = 4
    // 目安単価
    @State var unitPrice = "1001円~2000円"
    @State var unitPrices = ["~1000円", "1001円~2000円", "2001円~3000円", "3001円~4000円", "5001円~6000円", "7001円~8000円", "9001円~10000円", "10001円~"]
    @State var note = ""
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack() {
                        Text("募集人数：")
                        Text("\(numberOfPeople)人")
                    }
                    Picker("募集人数", selection: $numberOfPeople) {
                        ForEach(0 ..< 100, id: \.self) { num in
                            Text("\(num)人")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                } header: {
                    Text("募集人数を入力")
                }
                Section {
                    HStack() {
                        Text("目安単価：")
                        Text("\(unitPrice)")
                    }
                    Picker("目安単価", selection: $unitPrice) {
                        ForEach(unitPrices, id: \.self) { unitPrice in
                            Text("\(unitPrice)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                } header: {
                    Text("目安単価を入力")
                }
                Section {
                    TextEditor(text: $note)
                        .frame(height: 150)
                } header: {
                    Text("備考")
                }
            }
            Button(action: {
                create(shopID: viewModel.shopID, numberOfPeople: numberOfPeople, unitPrice: unitPrice, note: note)
//                Firestore.firestore().collection("shops").document(viewModel.shopID).setData(["numberOfPeople": numberOfPeople])
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    .foregroundStyle(.white)
                    .frame(height: 72)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(.green)
                    .cornerRadius(36)
            })
            
        }
        .padding()
        .onAppear{
            viewModel.onAppear()
        }
    }
    
    func create(shopID: String, numberOfPeople: Int, unitPrice: String, note: String) {
        let db = Firestore.firestore()
        let batch = db.batch()
        //Firestoreのコレクション内にshopsを作成。
        let shopsRef = db.collection("shops").document(shopID)
        //FireStoreに投稿データを保存する
        var dic = [String:Any]()
        dic["numberOfPeople"] = numberOfPeople
        dic["unitPrice"] = unitPrice
        dic["note"] = note

        batch.setData(dic, forDocument: shopsRef)

        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
            }
        }
    }
}


#Preview {
    RequirementSettingView()
}
