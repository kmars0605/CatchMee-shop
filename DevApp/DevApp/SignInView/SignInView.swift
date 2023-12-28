//
//  SignInView.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/27.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack() {
            // googleログインボタン
            GoogleAuthButton()
        }
        .navigationTitle("会員設定")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
