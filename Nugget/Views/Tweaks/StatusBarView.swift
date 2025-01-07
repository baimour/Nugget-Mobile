//
//  StatusBarTweaks.swift
//  Nugget
//
//  Created by lemin on 9/9/24.
//

import SwiftUI

struct StatusBarView: View {
    @State private var radioPrimarySelection = 1
//    @State private var cellularServiceEnabled: Bool = false
//    @State private var cellularServiceValue: Bool = false
    
    @State private var carrierText: String = ""
    @State private var carrierTextEnabled: Bool = false
    
    @State private var primaryServiceBadgeText: String = ""
    @State private var primaryServiceBadgeTextEnabled: Bool = false
    
    @State private var radioSecondarySelection = 1
//    @State private var secondCellularServiceEnabled: Bool = false
//    @State private var secondaryCellularServiceValue: Bool = false
    
    @State private var secondaryCarrierText: String = ""
    @State private var secondaryCarrierTextEnabled: Bool = false
    
    @State private var secondaryServiceBadgeText: String = ""
    @State private var secondaryServiceBadgeTextEnabled: Bool = false
    
    @State private var dateText: String = ""
    @State private var dateTextEnabled: Bool = false
    
    @State private var timeText: String = ""
    @State private var timeTextEnabled: Bool = false
    
    @State private var batteryDetailText: String = ""
    @State private var batteryDetailEnabled: Bool = false
    
    @State private var crumbText: String = ""
    @State private var crumbTextEnabled: Bool = false
    
    @State private var dataNetworkType: Int = 0
    @State private var dataNetworkTypeEnabled: Bool = false
    
    @State private var secondaryDataNetworkType: Int = 0
    @State private var secondaryDataNetworkTypeEnabled: Bool = false
    
    @State private var batteryCapacity: Double = 0
    @State private var batteryCapacityEnabled: Bool = false
    
    @State private var wiFiStrengthBars: Double = 0
    @State private var wiFiStrengthBarsEnabled: Bool = true
    
    @State private var gsmStrengthBars: Double = 0
    @State private var gsmStrengthBarsEnabled: Bool = false
    
    @State private var secondaryGsmStrengthBars: Double = 0
    @State private var secondaryGsmStrengthBarsEnabled: Bool = false
    
    @State private var displayingRawWiFiStrength: Bool = false
    @State private var displayingRawGSMStrength: Bool = false
    
    @State private var DNDHidden: Bool = true
    @State private var airplaneHidden: Bool = false
    @State private var cellHidden: Bool = false
    @State private var wiFiHidden: Bool = false
    @State private var batteryHidden: Bool = false
    @State private var bluetoothHidden: Bool = false
    @State private var alarmHidden: Bool = false
    @State private var locationHidden: Bool = false
    @State private var rotationHidden: Bool = false
    @State private var airPlayHidden: Bool = false
    @State private var carPlayHidden: Bool = false
    @State private var VPNHidden: Bool = false
    
    private var NetworkTypes: [String] = [
        "GPRS", // 0
        "EDGE", // 1
        "3G", // 2
        "4G", // 3
        "LTE", // 4
        "WiFi", // 5
        "Personal Hotspot", // 6
        "1x", // 7
        "5Gᴇ", // 8
        "LTE-A", // 9
        "LTE+", // 10
        "5G", // 11
        "5G+", // 12
        "5GUW", // 13
        "5GUC", // 14
        "White", // 15
    ]
    
    var body: some View {
        List {
            Section {
                
            } footer: {
                Text("测试功能，请谨慎使用。做好备份")
            }
            Section {
                Picker(selection: $radioPrimarySelection, label: Text("显示隐藏")) {
                    Text("默认").tag(1)
                    Text("强制显示").tag(2)
                    Text("强制隐藏").tag(3)
                }
                .pickerStyle(.menu)
                .onChange(of: radioPrimarySelection) { new in
                    if new == 1 {
                        StatusManager.sharedInstance().unsetCellularService()
                    } else if new == 2 {
                        StatusManager.sharedInstance().setCellularService(true)
                    } else if new == 3 {
                        StatusManager.sharedInstance().setCellularService(false)
                    }
                }
                .onAppear {
                    let serviceEnabled = StatusManager.sharedInstance().isCellularServiceOverridden()
                    if serviceEnabled {
                        let serviceValue = StatusManager.sharedInstance().getCellularServiceOverride()
                        if serviceValue {
                            radioPrimarySelection = 2
                        } else {
                            radioPrimarySelection = 3
                        }
                    } else {
                        radioPrimarySelection = 1
                    }
                }
                
                //                            Toggle("Change Service Status", isOn: $cellularServiceEnabled).onChange(of: cellularServiceEnabled, perform: { nv in
                //                                if nv {
                //                                    StatusManager.sharedInstance().setCellularService(cellularServiceValue)
                //                                } else {
                //                                    StatusManager.sharedInstance().unsetCellularService()
                //                                }
                //                            }).onAppear(perform: {
                //                                cellularServiceEnabled = StatusManager.sharedInstance().isCellularServiceOverridden()
                //                            })
                //                            if cellularServiceEnabled {
                //                                Toggle("Cellular Service Enabled", isOn: $cellularServiceValue).onChange(of: cellularServiceValue, perform: { nv in
                //                                    if cellularServiceEnabled {
                //                                        StatusManager.sharedInstance().setCellularService(nv)
                //                                    }
                //                                }).onAppear(perform: {
                //                                    cellularServiceValue = StatusManager.sharedInstance().getCellularServiceOverride()
                //                                })
                //                            }
                
                Toggle("更改主卡运营商名称", isOn: $carrierTextEnabled).onChange(of: carrierTextEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setCarrier(carrierText)
                    } else {
                        StatusManager.sharedInstance().unsetCarrier()
                    }
                }).onAppear(perform: {
                    carrierTextEnabled = StatusManager.sharedInstance().isCarrierOverridden()
                })
                TextField("主卡运营商名称", text: $carrierText).onChange(of: carrierText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 100
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while safeNv.utf8CString.count > 100 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    carrierText = safeNv
                    if carrierTextEnabled {
                        StatusManager.sharedInstance().setCarrier(safeNv)
                    }
                }).onAppear(perform: {
                    carrierText = StatusManager.sharedInstance().getCarrierOverride()
                })
                Toggle("更改主卡服务徽章文字", isOn: $primaryServiceBadgeTextEnabled).onChange(of: primaryServiceBadgeTextEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setPrimaryServiceBadge(primaryServiceBadgeText)
                    } else {
                        StatusManager.sharedInstance().unsetPrimaryServiceBadge()
                    }
                }).onAppear(perform: {
                    primaryServiceBadgeTextEnabled = StatusManager.sharedInstance().isPrimaryServiceBadgeOverridden()
                })
                TextField("主卡服务徽章文字", text: $primaryServiceBadgeText).onChange(of: primaryServiceBadgeText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 100
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while safeNv.utf8CString.count > 100 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    primaryServiceBadgeText = safeNv
                    if primaryServiceBadgeTextEnabled {
                        StatusManager.sharedInstance().setPrimaryServiceBadge(safeNv)
                    }
                }).onAppear(perform: {
                    primaryServiceBadgeText = StatusManager.sharedInstance().getPrimaryServiceBadgeOverride()
                })
                
                Toggle("更改数据网络类型", isOn: $dataNetworkTypeEnabled).onChange(of: dataNetworkTypeEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setDataNetworkType(Int32(dataNetworkType))
                    } else {
                        StatusManager.sharedInstance().unsetDataNetworkType()
                    }
                }).onAppear(perform: {
                    dataNetworkTypeEnabled = StatusManager.sharedInstance().isDataNetworkTypeOverridden()
                })
                HStack {
                    Text("数据网络类型")
                    Spacer()
                    
                    Menu {
                        ForEach(Array(NetworkTypes.enumerated()), id: \.offset) { i, net in
                            if net != "???" {
                                Button(action: {
                                    dataNetworkType = i
                                    if dataNetworkTypeEnabled {
                                        StatusManager.sharedInstance().setDataNetworkType(Int32(dataNetworkType))
                                    }
                                }) {
                                    Text(net)
                                }
                            }
                        }
                    } label: {
                        Text(NetworkTypes[dataNetworkType])
                    }
                }.onAppear(perform: {
                    dataNetworkType = Int(StatusManager.sharedInstance().getDataNetworkTypeOverride())
                })
            } header: {
                Text("主卡运营商")
            }
            
            Section {
                Picker(selection: $radioSecondarySelection, label: Text("显示隐藏")) {
                    Text("默认").tag(1)
                    Text("强制显示").tag(2)
                    Text("强制隐藏").tag(3)
                }
                .pickerStyle(.menu)
                .onChange(of: radioSecondarySelection) { new in
                    if new == 1 {
                        StatusManager.sharedInstance().unsetSecondaryCellularService()
                    } else if new == 2 {
                        StatusManager.sharedInstance().setSecondaryCellularService(true)
                    } else if new == 3 {
                        StatusManager.sharedInstance().setSecondaryCellularService(false)
                    }
                }
                .onAppear {
                    let serviceEnabled = StatusManager.sharedInstance().isSecondaryCellularServiceOverridden()
                    if serviceEnabled {
                        let serviceValue = StatusManager.sharedInstance().getSecondaryCellularServiceOverride()
                        if serviceValue {
                            radioSecondarySelection = 2
                        } else {
                            radioSecondarySelection = 3
                        }
                    } else {
                        radioSecondarySelection = 1
                    }
                }
                
                //                            Toggle("Change Secondary Service Status", isOn: $secondCellularServiceEnabled).onChange(of: secondCellularServiceEnabled, perform: { nv in
                //                                if nv {
                //                                    StatusManager.sharedInstance().setSecondaryCellularService(secondaryCellularServiceValue)
                //                                } else {
                //                                    StatusManager.sharedInstance().unsetSecondaryCellularService()
                //                                }
                //                            }).onAppear(perform: {
                //                                secondCellularServiceEnabled = StatusManager.sharedInstance().isSecondaryCellularServiceOverridden()
                //                            })
                //                            if secondCellularServiceEnabled {
                //                                Toggle("Secondary Cellular Service Enabled", isOn: $secondaryCellularServiceValue).onChange(of: secondaryCellularServiceValue, perform: { nv in
                //                                    if secondCellularServiceEnabled {
                //                                        StatusManager.sharedInstance().setSecondaryCellularService(nv)
                //                                    }
                //                                }).onAppear(perform: {
                //                                    secondaryCellularServiceValue = StatusManager.sharedInstance().getSecondaryCellularServiceOverride()
                //                                })
                //                            }
                
                Toggle("更改副卡运营商名称", isOn: $secondaryCarrierTextEnabled).onChange(of: secondaryCarrierTextEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setSecondaryCarrier(secondaryCarrierText)
                    } else {
                        StatusManager.sharedInstance().unsetSecondaryCarrier()
                    }
                }).onAppear(perform: {
                    secondaryCarrierTextEnabled = StatusManager.sharedInstance().isSecondaryCarrierOverridden()
                })
                TextField("副卡运营商名称", text: $secondaryCarrierText).onChange(of: secondaryCarrierText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 100
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while safeNv.utf8CString.count > 100 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    secondaryCarrierText = safeNv
                    if secondaryCarrierTextEnabled {
                        StatusManager.sharedInstance().setSecondaryCarrier(safeNv)
                    }
                }).onAppear(perform: {
                    secondaryCarrierText = StatusManager.sharedInstance().getSecondaryCarrierOverride()
                })
                Toggle("更改副卡服务徽章文字", isOn: $secondaryServiceBadgeTextEnabled).onChange(of: secondaryServiceBadgeTextEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setSecondaryServiceBadge(secondaryServiceBadgeText)
                    } else {
                        StatusManager.sharedInstance().unsetSecondaryServiceBadge()
                    }
                }).onAppear(perform: {
                    secondaryServiceBadgeTextEnabled = StatusManager.sharedInstance().isSecondaryServiceBadgeOverridden()
                })
                TextField("副卡服务徽章文字", text: $secondaryServiceBadgeText).onChange(of: secondaryServiceBadgeText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 100
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while safeNv.utf8CString.count > 100 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    secondaryServiceBadgeText = safeNv
                    if secondaryServiceBadgeTextEnabled {
                        StatusManager.sharedInstance().setSecondaryServiceBadge(safeNv)
                    }
                }).onAppear(perform: {
                    secondaryServiceBadgeText = StatusManager.sharedInstance().getSecondaryServiceBadgeOverride()
                })
                
                Toggle("更改副卡数据网络类型", isOn: $secondaryDataNetworkTypeEnabled).onChange(of: secondaryDataNetworkTypeEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setSecondaryDataNetworkType(Int32(secondaryDataNetworkType))
                    } else {
                        StatusManager.sharedInstance().unsetSecondaryDataNetworkType()
                    }
                }).onAppear(perform: {
                    secondaryDataNetworkTypeEnabled = StatusManager.sharedInstance().isSecondaryDataNetworkTypeOverridden()
                })
                
                HStack {
                    Text("副卡数据网络类型")
                    Spacer()
                    
                    Menu {
                        ForEach(Array(NetworkTypes.enumerated()), id: \.offset) { i, net in
                            if net != "???" {
                                Button(action: {
                                    secondaryDataNetworkType = i
                                    if secondaryDataNetworkTypeEnabled {
                                        StatusManager.sharedInstance().setSecondaryDataNetworkType(Int32(secondaryDataNetworkType))
                                    }
                                }) {
                                    Text(net)
                                }
                            }
                        }
                    } label: {
                        Text(NetworkTypes[secondaryDataNetworkType])
                    }
                }.onAppear(perform: {
                    secondaryDataNetworkType = Int(StatusManager.sharedInstance().getSecondaryDataNetworkTypeOverride())
                })
            } header: {
                Text("副卡运营商")
            }
            Section {
                Toggle("更改面包屑文字", isOn: $crumbTextEnabled).onChange(of: crumbTextEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setCrumb(crumbText)
                    } else {
                        StatusManager.sharedInstance().unsetCrumb()
                    }
                }).onAppear(perform: {
                    crumbTextEnabled = StatusManager.sharedInstance().isCrumbOverridden()
                })
                TextField("面包屑文字", text: $crumbText).onChange(of: crumbText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 256
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while (safeNv + " ▶").utf8CString.count > 256 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    crumbText = safeNv
                    if crumbTextEnabled {
                        StatusManager.sharedInstance().setCrumb(safeNv)
                    }
                }).onAppear(perform: {
                    crumbText = StatusManager.sharedInstance().getCrumbOverride()
                })
                Toggle("更改电池详细信息文字", isOn: $batteryDetailEnabled).onChange(of: batteryDetailEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setBatteryDetail(batteryDetailText)
                    } else {
                        StatusManager.sharedInstance().unsetBatteryDetail()
                    }
                }).onAppear(perform: {
                    batteryDetailEnabled = StatusManager.sharedInstance().isBatteryDetailOverridden()
                })
                TextField("电池详细信息文字", text: $batteryDetailText).onChange(of: batteryDetailText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 150
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while safeNv.utf8CString.count > 150 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    batteryDetailText = safeNv
                    if batteryDetailEnabled {
                        StatusManager.sharedInstance().setBatteryDetail(safeNv)
                    }
                }).onAppear(perform: {
                    batteryDetailText = StatusManager.sharedInstance().getBatteryDetailOverride()
                })
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Toggle("更改状态栏日期文字", isOn: $dateTextEnabled).onChange(of: dateTextEnabled, perform: { nv in
                        if nv {
                            StatusManager.sharedInstance().setDate(dateText)
                        } else {
                            StatusManager.sharedInstance().unsetDate()
                        }
                    }).onAppear(perform: {
                        dateTextEnabled = StatusManager.sharedInstance().isDateOverridden()
                    })
                    TextField("状态栏日期文字", text: $dateText).onChange(of: dateText, perform: { nv in
                        // This is important.
                        // Make sure the UTF-8 representation of the string does not exceed 64
                        // Otherwise the struct will overflow
                        var safeNv = nv
                        while safeNv.utf8CString.count > 256 {
                            safeNv = String(safeNv.prefix(safeNv.count - 1))
                        }
                        dateText = safeNv
                        if dateTextEnabled {
                            StatusManager.sharedInstance().setDate(safeNv)
                        }
                    }).onAppear(perform: {
                        dateText = StatusManager.sharedInstance().getDateOverride()
                    })
                }
                Toggle("更改状态栏时间文字", isOn: $timeTextEnabled).onChange(of: timeTextEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setTime(timeText)
                    } else {
                        StatusManager.sharedInstance().unsetTime()
                    }
                }).onAppear(perform: {
                    timeTextEnabled = StatusManager.sharedInstance().isTimeOverridden()
                })
                TextField("状态栏时间文字", text: $timeText).onChange(of: timeText, perform: { nv in
                    // This is important.
                    // Make sure the UTF-8 representation of the string does not exceed 64
                    // Otherwise the struct will overflow
                    var safeNv = nv
                    while safeNv.utf8CString.count > 64 {
                        safeNv = String(safeNv.prefix(safeNv.count - 1))
                    }
                    timeText = safeNv
                    if timeTextEnabled {
                        StatusManager.sharedInstance().setTime(safeNv)
                    }
                }).onAppear(perform: {
                    timeText = StatusManager.sharedInstance().getTimeOverride()
                })
            } footer: {
                Text("在全面屏设备上设置为空时，将显示运营商名称")
            }
            
            Section {
                Toggle("更改电池图标容量", isOn: $batteryCapacityEnabled).onChange(of: batteryCapacityEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setBatteryCapacity(Int32(batteryCapacity))
                    } else {
                        StatusManager.sharedInstance().unsetBatteryCapacity()
                    }
                }).onAppear(perform: {
                    batteryCapacityEnabled = StatusManager.sharedInstance().isBatteryCapacityOverridden()
                })
                HStack {
                    Text("\(Int(batteryCapacity))%")
                        .frame(width: 35)
                    Spacer()
                    Slider(value: $batteryCapacity, in: 0...100, step: 1.0)
                        .padding(.horizontal)
                        .onChange(of: batteryCapacity) { nv in
                            StatusManager.sharedInstance().setBatteryCapacity(Int32(nv))
                        }
                        .onAppear(perform: {
                            batteryCapacity = Double(StatusManager.sharedInstance().getBatteryCapacityOverride())
                        })
                }
                
                Toggle("更改WiFi信号强度条", isOn: $wiFiStrengthBarsEnabled).onChange(of: wiFiStrengthBarsEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setWiFiSignalStrengthBars(Int32(wiFiStrengthBars))
                    } else {
                        StatusManager.sharedInstance().unsetWiFiSignalStrengthBars()
                    }
                }).onAppear(perform: {
                    wiFiStrengthBarsEnabled = StatusManager.sharedInstance().isWiFiSignalStrengthBarsOverridden()
                })
                HStack {
                    Text("\(Int(wiFiStrengthBars))")
                        .frame(width: 35)
                    Spacer()
                    Slider(value: $wiFiStrengthBars, in: 0...3, step: 1.0)
                        .padding(.horizontal)
                        .onChange(of: wiFiStrengthBars) { nv in
                            StatusManager.sharedInstance().setWiFiSignalStrengthBars(Int32(nv))
                        }
                        .onAppear(perform: {
                            wiFiStrengthBars = Double(StatusManager.sharedInstance().getWiFiSignalStrengthBarsOverride())
                        })
                }
                
                Toggle("更改主卡信号强度条", isOn: $gsmStrengthBarsEnabled).onChange(of: gsmStrengthBarsEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setGsmSignalStrengthBars(Int32(gsmStrengthBars))
                    } else {
                        StatusManager.sharedInstance().unsetGsmSignalStrengthBars()
                    }
                }).onAppear(perform: {
                    gsmStrengthBarsEnabled = StatusManager.sharedInstance().isGsmSignalStrengthBarsOverridden()
                })
                HStack {
                    Text("\(Int(gsmStrengthBars))")
                        .frame(width: 35)
                    Spacer()
                    Slider(value: $gsmStrengthBars, in: 0...4, step: 1.0)
                        .padding(.horizontal)
                        .onChange(of: gsmStrengthBars) { nv in
                            StatusManager.sharedInstance().setGsmSignalStrengthBars(Int32(nv))
                        }
                        .onAppear(perform: {
                            gsmStrengthBars = Double(StatusManager.sharedInstance().getGsmSignalStrengthBarsOverride())
                        })
                }
                
                Toggle("更改副卡信号强度条", isOn: $secondaryGsmStrengthBarsEnabled).onChange(of: secondaryGsmStrengthBarsEnabled, perform: { nv in
                    if nv {
                        StatusManager.sharedInstance().setSecondaryGsmSignalStrengthBars(Int32(secondaryGsmStrengthBars))
                    } else {
                        StatusManager.sharedInstance().unsetSecondaryGsmSignalStrengthBars()
                    }
                }).onAppear(perform: {
                    secondaryGsmStrengthBarsEnabled = StatusManager.sharedInstance().isSecondaryGsmSignalStrengthBarsOverridden()
                })
                HStack {
                    Text("\(Int(secondaryGsmStrengthBars))")
                        .frame(width: 35)
                    Spacer()
                    Slider(value: $secondaryGsmStrengthBars, in: 0...4, step: 1.0)
                        .padding(.horizontal)
                        .onChange(of: secondaryGsmStrengthBars) { nv in
                            StatusManager.sharedInstance().setSecondaryGsmSignalStrengthBars(Int32(nv))
                        }
                        .onAppear(perform: {
                            secondaryGsmStrengthBars = Double(StatusManager.sharedInstance().getSecondaryGsmSignalStrengthBarsOverride())
                        })
                }
            }
            
            Section {
                Toggle("显示数字WiFi强度", isOn: $displayingRawWiFiStrength).onChange(of: displayingRawWiFiStrength, perform: { nv in
                    StatusManager.sharedInstance().displayRawWifiSignal(nv)
                }).onAppear(perform: {
                    displayingRawWiFiStrength = StatusManager.sharedInstance().isDisplayingRawWiFiSignal()
                })
                Toggle("显示数字蜂窝强度", isOn: $displayingRawGSMStrength).onChange(of: displayingRawGSMStrength, perform: { nv in
                    StatusManager.sharedInstance().displayRawGSMSignal(nv)
                }).onAppear(perform: {
                    displayingRawGSMStrength = StatusManager.sharedInstance().isDisplayingRawGSMSignal()
                })
            }
            
            Section {
                Toggle("隐藏勿扰模式图标", isOn: $DNDHidden).onChange(of: DNDHidden, perform: { nv in
                    StatusManager.sharedInstance().hideDND(nv)
                }).onAppear(perform: {
                    DNDHidden = StatusManager.sharedInstance().isDNDHidden()
                })
                Toggle("隐藏飞行模式图标", isOn: $airplaneHidden).onChange(of: airplaneHidden, perform: { nv in
                    StatusManager.sharedInstance().hideAirplane(nv)
                }).onAppear(perform: {
                    airplaneHidden = StatusManager.sharedInstance().isAirplaneHidden()
                })
                Toggle("隐藏蜂窝*", isOn: $cellHidden).onChange(of: cellHidden, perform: { nv in
                    StatusManager.sharedInstance().hideCell(nv)
                }).onAppear(perform: {
                    cellHidden = StatusManager.sharedInstance().isCellHidden()
                })
            }
            Section {
                Toggle("隐藏WiFi^", isOn: $wiFiHidden).onChange(of: wiFiHidden, perform: { nv in
                    StatusManager.sharedInstance().hideWiFi(nv)
                }).onAppear(perform: {
                    wiFiHidden = StatusManager.sharedInstance().isWiFiHidden()
                })
                //                if UIDevice.current.userInterfaceIdiom != .pad {
                Toggle("隐藏电池", isOn: $batteryHidden).onChange(of: batteryHidden, perform: { nv in
                    StatusManager.sharedInstance().hideBattery(nv)
                }).onAppear(perform: {
                    batteryHidden = StatusManager.sharedInstance().isBatteryHidden()
                })
                //                }
                Toggle("隐藏蓝牙", isOn: $bluetoothHidden).onChange(of: bluetoothHidden, perform: { nv in
                    StatusManager.sharedInstance().hideBluetooth(nv)
                }).onAppear(perform: {
                    bluetoothHidden = StatusManager.sharedInstance().isBluetoothHidden()
                })
                Toggle("隐藏弹窗", isOn: $alarmHidden).onChange(of: alarmHidden, perform: { nv in
                    StatusManager.sharedInstance().hideAlarm(nv)
                }).onAppear(perform: {
                    alarmHidden = StatusManager.sharedInstance().isAlarmHidden()
                })
                Toggle("隐藏定位", isOn: $locationHidden).onChange(of: locationHidden, perform: { nv in
                    StatusManager.sharedInstance().hideLocation(nv)
                }).onAppear(perform: {
                    locationHidden = StatusManager.sharedInstance().isLocationHidden()
                })
                Toggle("隐藏旋转锁定", isOn: $rotationHidden).onChange(of: rotationHidden, perform: { nv in
                    StatusManager.sharedInstance().hideRotation(nv)
                }).onAppear(perform: {
                    rotationHidden = StatusManager.sharedInstance().isRotationHidden()
                })
                Toggle("隐藏隔空投送", isOn: $airPlayHidden).onChange(of: airPlayHidden, perform: { nv in
                    StatusManager.sharedInstance().hideAirPlay(nv)
                }).onAppear(perform: {
                    airPlayHidden = StatusManager.sharedInstance().isAirPlayHidden()
                })
                Toggle("隐藏CarPlay", isOn: $carPlayHidden).onChange(of: carPlayHidden, perform: { nv in
                    StatusManager.sharedInstance().hideCarPlay(nv)
                }).onAppear(perform: {
                    carPlayHidden = StatusManager.sharedInstance().isCarPlayHidden()
                })
                Toggle("隐藏VPN", isOn: $VPNHidden).onChange(of: VPNHidden, perform: { nv in
                    StatusManager.sharedInstance().hideVPN(nv)
                }).onAppear(perform: {
                    VPNHidden = StatusManager.sharedInstance().isVPNHidden()
                })
            } footer: {
                Text("*也会隐藏运营商名称\n^也会隐藏蜂窝数据指示器")
            }
        }
        .tweakToggle(for: .StatusBar)
        .navigationTitle("状态栏")
    }
}

