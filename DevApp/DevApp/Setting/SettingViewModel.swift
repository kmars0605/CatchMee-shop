//
//  SettingViewModel.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/27.
//

import Foundation
import FirebaseAuth

enum SettingViewList: Identifiable {
    case auth
    
    var id: String {
        switch self {
        case .auth:
            return "auth"
        }
    }
}

final class SettingViewModel: ObservableObject {
    
    @Published var userName = "未設定"
    
    @Published var selectedItem: SettingViewList?
    
    func onAppear() {
        if let user = Auth.auth().currentUser {
            userName = user.displayName ?? ""
        } else {
            userName = "未設定"
        }
    }
}

