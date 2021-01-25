//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(iOS)
import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0) }
    }
    
    func shake(duration: CFTimeInterval = 0.6, _ completion: (()->Void)? = nil) {
        CATransaction.begin()
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        CATransaction.setCompletionBlock(completion)
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, bounds: CGRect? = nil) {
        let path = UIBezierPath(roundedRect: bounds ?? self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                                           options: [],
                                                           metrics: ["inset": inset, "thickness": thickness],
                                                           views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
    func pinToEdges(with margin: CGFloat = 0) {
        precondition(superview != nil, "Unable activate constraint since superview is not found")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor),
            self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, constant: -margin),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, constant: -margin)
        ])
    }
    
    func addSeparatorView(height: CGFloat = 0.4,color: UIColor = ExtensionColors.seperatorColor){
        let separatorLine = UIView()
        separatorLine.backgroundColor = color
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

//MARK: Shimmer Animation
public extension UIView {
    
    struct ShimmerAssociatedKey {
        static var key = 0
    }
    
    fileprivate var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &ShimmerAssociatedKey.key) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &ShimmerAssociatedKey.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var shimmerAnimation: Bool {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}

public protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

public extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 1.0) {
        // create effect
        let effect = UIBlurEffect(style: .extraLight)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

// Conformance
extension UIView: Bluring {}

public extension UIImageView {
    func setBlurredImage(fromSourceImage image: UIImage) {
        let inputImage = CIImage(image: image)
        let size = image.size
        DispatchQueue.global(qos: .userInitiated).async {
            let filter = CIFilter(name: "CIGaussianBlur")
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            filter?.setValue(10, forKey: kCIInputRadiusKey)
            let blurred = filter?.outputImage
            
            guard let extent = blurred?.extent else {return}
            
            var newImageSize: CGRect = extent
            newImageSize.origin.x += (newImageSize.size.width - size.width) / 2
            newImageSize.origin.y += (newImageSize.size.height - size.height) / 2
            newImageSize.size = image.size
            
            let context: CIContext = CIContext(options: nil)
            
            guard let resultImage: CIImage = filter?.value(forKey: "outputImage") as? CIImage,
                  let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)
            else {return}
            
            DispatchQueue.main.async {
                self.image = UIImage.init(cgImage: cgimg)
            }
        }
    }
}


#endif


