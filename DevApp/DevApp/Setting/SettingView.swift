//
//  Setting.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/27.
//

import SwiftUI

public struct SettingView: View {
    @StateObject var viewModel = SettingViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: SectionHeader(section: "登録")) {
                        NavigationLink(destination: SignInView()) {
                            SettingRow(item: .auth)
                        }
                    }
                    Text(viewModel.userName)
                }
                .scrollDisabled(true)
                .navigationTitle("設定")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}


private struct SettingRow: View {
    let item: SettingViewList
    var body: some View {
        HStack {
            HStack {
                Text(item.id)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .contentShape(Rectangle())
    }
}

private struct SectionHeader: View {
    let section: String
    
    public init(section: String) {
        self.section = section
    }
    
    public var body: some View {
        HStack {
            Text(section)
                .foregroundStyle(.black)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingView()
        }
        .previewLayout(.sizeThatFits)
    }
}

