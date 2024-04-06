//
//  LoginView.swift
//  Only77
//
//  Created by yukun xie on 2024/3/27.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @AppStorage("isUserAuthenticated") private var isUserAuthenticated = false
    var body: some View {
        Group{
            if isUserAuthenticated {
                MainView().preferredColorScheme(.light)
            }else {SignInWithAppleButton(.signIn,onRequest: { request in
                request.requestedScopes = [.fullName, .email] },
                                         onCompletion: { result in
                switch result {
                case .success(let authResults):
                    isUserAuthenticated = true
                    print("授权成功: \(authResults)")
                case .failure(let error):
                    print("授权失败: \(error)")
                }
            })
            .frame(width: 280, height: 60)
            .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
