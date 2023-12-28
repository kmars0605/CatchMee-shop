//
//  RequirementSettingViewModel.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/27.
//

import Foundation
import Firebase

final class RequirementSettingViewModel: ObservableObject {
    
    @Published var shopID = ""
    
    func onAppear() {
        if let uid = Auth.auth().currentUser?.uid {
            shopID = uid
        } else {
            shopID = "未設定"
        }
    }
}
