//
//  RevertTweaksPopoverView.swift
//  Nugget
//
//  Created by lemin on 9/17/24.
//

import SwiftUI

struct RevertTweaksPopoverView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var applyHandler = ApplyHandler.shared
    let revertFunction: (_ reverting: Bool) -> Void
    
    struct TweakOption: Identifiable {
        var id = UUID()
        var page: TweakPage
        var enabled: Bool
    }
    
    @State var tweakOptions: [TweakOption] = []
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach($tweakOptions) { option in
                        Toggle(isOn: option.enabled) {
                            Text("还原\(option.page.wrappedValue.rawValue)")
                        }
                        .toggleStyle(.switch)
                        .onChange(of: option.enabled.wrappedValue) { nv in
                            if nv {
                                applyHandler.removingTweaks.insert(option.page.wrappedValue)
                            } else {
                                applyHandler.removingTweaks.remove(option.page.wrappedValue)
                            }
                        }
                    }
                }
                .navigationTitle("选择功能")
                Section {
                    // Apply button
                    Button("移除功能") {
                        dismiss()
                        revertFunction(true)
                    }
                    .buttonStyle(TintedButton(color: .red, fullwidth: true))
                    // Cancel button
                    Button("取消") {
                        dismiss()
                    }
                    .buttonStyle(TintedButton(color: .blue, fullwidth: true))
                }
            }
            .onAppear {
                for page in TweakPage.allCases {
                    tweakOptions.append(.init(page: page, enabled: applyHandler.removingTweaks.contains(page)))
                }
            }
        }
    }
}
