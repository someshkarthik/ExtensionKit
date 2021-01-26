

#if canImport(UIKit)
import UIKit
#endif


public struct ExtensionKit {
    
    public struct Localised {
        public var fileName: String = "ExtensionKitLocalizable"
        public var value: String = ""
        public var comment: String = ""
    }
    
    public static var localised = Localised()
    
    #if canImport(Cocoa)
    
    public static var mainStoryBoardName = "Main"
    
    #endif
    
    #if canImport(UIKit)
    
    public static var windowTransitionBackgroundColor: UIColor = ExtensionColors.bgColorWhite
    public static var tintColor: UIColor = ExtensionColors.tintColor
    
    #endif
    
}

