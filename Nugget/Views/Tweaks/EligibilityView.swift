//
//  EligibilityView.swift
//  Nugget
//
//  Created by lemin on 9/20/24.
//

import SwiftUI

struct EligibilityView: View {
    @StateObject var manager = EligibilityManager.shared
    
    @State var euEnabler: Bool = false
    
    @State var aiEnabler: Bool = false
    @State var changeDeviceModel: Bool = false
    
    var body: some View {
        List {
            // MARK: EU Enabler
//            Section {
//                Toggle(isOn: $euEnabler) {
//                    Text("Enable EU Sideloading")
//                }.onChange(of: euEnabler) { nv in
//                    manager.euEnabler = nv
//                }
//            } header: {
//                Text("EU Enabler")
//            }
            
            // MARK: AI Enabler
            if #available(iOS 18.1, *) {
                Section {
                    Toggle(isOn: $aiEnabler) {
                        HStack {
                            Text("启用苹果AI智能")
                            Spacer()
                            Button(action: {
                                showInfoAlert(NSLocalizedString("在不支持的设备上启用苹果AI智能，下载可能需要很长时间。请耐心检查 [设置] -> 通用 -> iPhone/iPad储存空间 -> iOS -> Apple Intelligence查看是否正在下载\n\n如果不生效，请再试一次", comment: "AI info popup"))
                            }) {
                                Image(systemName: "info.circle")
                            }
                        }
                    }.onChange(of: aiEnabler) { nv in
                        manager.toggleAI(nv)
                    }
                    if aiEnabler {
                        Toggle(isOn: $changeDeviceModel) {
                            HStack {
                                Text("伪装设备型号")
                                Spacer()
                                Button(action: {
                                    showInfoAlert(NSLocalizedString("将您的设备型号伪装为iPhone 16(或iPad Pro M4)，让你可以下载AI模型\n\n打开此选项可下载模型，然后关闭此选项并在下载模型后重新应用\n\n注意：启用此选项后，会破坏面容 ID。还原文件可修复此问题", comment: "Device model changer info popup"))
                                }) {
                                    Image(systemName: "info.circle")
                                }
                            }
                        }.onChange(of: changeDeviceModel) { nv in
                            manager.setDeviceModelCode(nv)
                        }
                    }
                } header: {
                    Text("AI启用工具")
                }
            }
        }
        .tweakToggle(for: .Eligibility)
        .navigationTitle("苹果AI智能")
        .onAppear {
            euEnabler = manager.euEnabler
            aiEnabler = manager.aiEnabler
            changeDeviceModel = manager.spoofingDevice
        }
    }
    
    func showInfoAlert(_ body: String) {
        UIApplication.shared.alert(title: "信息", body: body)
    }
}
