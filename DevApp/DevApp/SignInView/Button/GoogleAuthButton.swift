//
//  GoogleAuthButton.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/27.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

struct GoogleAuthButton: View {
    var body: some View {
        VStack {
            Button(action: {
                // action
                googleAuth()
            }){
                Text("Googleでサインイン")
                    .font(.title3)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 2)
            )
            // 文字色を指定
            .foregroundColor(.black)
            .padding(EdgeInsets(
                top: 0,
                leading: 20,
                bottom: 0,
                trailing: 20
            ))
            if let user = Auth.auth().currentUser {
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                    }
                    catch let error as NSError {
                        print(error)
                    }
                }, label: {
                    Text("サインアウト")
                })
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black, lineWidth: 2)
                )
                // 文字色を指定
                .foregroundColor(.black)
                .padding(EdgeInsets(
                    top: 0,
                    leading: 20,
                    bottom: 0,
                    trailing: 20
                ))
            }
        }
    }

    // Google会員登録
    private func googleAuth() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootViewController = windowScene?.windows.first!.rootViewController!

        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController!) { user, error in
            if let error = error {
                print("GIDSignInError: \(error.localizedDescription)")
                return
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            self.login(credential: credential)
        }
    }
    private func login(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("SignInError: \(error.localizedDescription)")
                return
            }
            guard let user = authResult?.user else { return }
        }
    }
}

struct GoogleAuthButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAuthButton()
            .previewLayout(.sizeThatFits)
    }
}
