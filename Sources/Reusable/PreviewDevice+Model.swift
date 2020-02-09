import SwiftUI

public extension PreviewDevice {
    
    /// Note: Mapping coming from https://developer.apple.com/documentation/swiftui/list/3270295-previewdevice
    enum Model: String {
        case iPhone7 = "iPhone 7"
        case iPhone7Plus = "iPhone 7 Plus"
        case iPhone8 = "iPhone 8"
        case iPhone8Plus = "iPhone 8 Plus"
        case iPhoneSE = "iPhone SE"
        case iPhoneX = "iPhone X"
        case iPhoneXs = "iPhone Xs"
        case iPhoneXsMax = "iPhone Xs Max"
        case iPhoneXr = "iPhone Xr"
        case iPadMini4 = "iPad mini 4"
        case iPadAir2 = "iPad Air 2"
        case iPadPro_9_7inch = "iPad Pro (9.7-inch)"
        case iPadPro_12_9inch = "iPad Pro (12.9-inch)"
        case iPad5 = "iPad (5th generation)"
        case iPadPro_12_9inch2 = "iPad Pro (12.9-inch) (2nd generation)"
        case iPadPro_10_5inch = "iPad Pro (10.5-inch)"
        case iPad6 = "iPad (6th generation)"
        case iPadPro_11inch = "iPad Pro (11-inch)"
        case iPadPro_12_9inch3 = "iPad Pro (12.9-inch) (3rd generation)"
        case iPadMini5 = "iPad mini (5th generation)"
        case iPadAir3 = "iPad Air (3rd generation)"
    }
    
    init(model: PreviewDevice.Model) {
        self.init(rawValue: model.rawValue)
    }
}
