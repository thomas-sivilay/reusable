import UIKit

public struct KeyboardNotificationInfo {
    public var frame: (begin: CGRect, end: CGRect)
    public let animation: (options: UIView.AnimationOptions, duration: TimeInterval)

    public init?(_ notification: Notification, convertFrameUsing sourceView: UIView? = nil) {
        guard let info = notification.userInfo,
            let beginFrame = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let endFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let animationOptionsRaw = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
            return nil
        }

        self.animation = (options: UIView.AnimationOptions(rawValue: animationOptionsRaw), duration: animationDuration)
        if let sourceView = sourceView {
            self.frame = (begin: sourceView.convert(beginFrame, from: nil),
                          end: sourceView.convert(endFrame, from: nil))
        } else {
            self.frame = (begin: beginFrame,
                          end: endFrame)
        }
    }

    public mutating func convertFrame(using sourceView: UIView) {
        frame.begin = sourceView.convert(frame.begin, from: nil)
        frame.end = sourceView.convert(frame.end, from: nil)
    }
}

public protocol KeyboardHandlerDelegate: AnyObject {
    func keyboardWillShow(info: KeyboardNotificationInfo)
    func keyboardWillHide(info: KeyboardNotificationInfo)
}

/// Note: Will default to use self as a delegate which will update the given scrollView content+scrollIndicator insets.
public final class UIKeyboardHandler: KeyboardHandlerDelegate {

    // MARK: - Properties
    
    public weak var delegate: KeyboardHandlerDelegate?
    public weak var scrollView: UIScrollView?
    
    public var isKeyboardShowing: Bool = false
    private var adjustedHeight: CGFloat = 0
    private var extraAdjustedHeight: CGFloat = 0

    // MARK: - Initializers
    public init(extraAdjustedHeight: CGFloat = 0) {
        self.delegate = self
        self.extraAdjustedHeight = extraAdjustedHeight
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Public -
    public func adjustHeight(of frame: CGRect, to view: UIView) -> CGFloat {
        var height = frame.height
        if #available(iOS 11, *) {
            height -= view.safeAreaInsets.bottom
        }
        height -= extraAdjustedHeight
        return height
    }

    // MARK: - Delegate -
    public func keyboardWillShow(info: KeyboardNotificationInfo) {
        guard let scrollView = scrollView else {
            return
        }
        let newAdjustedHeight = adjustHeight(of: info.frame.end, to: scrollView)
        let delta = newAdjustedHeight - adjustedHeight
        scrollView.contentInset.bottom += delta
        scrollView.scrollIndicatorInsets.bottom += delta
        adjustedHeight = newAdjustedHeight
    }

    public func keyboardWillHide(info: KeyboardNotificationInfo) {
        guard let scrollView = scrollView else {
            return
        }
        scrollView.contentInset.bottom -= adjustedHeight
        scrollView.scrollIndicatorInsets.bottom -= adjustedHeight
        adjustedHeight = 0
    }

    // MARK: - Private -
    @objc
    private func handleKeyboardWillShow(notification: Notification) {
        guard let info = KeyboardNotificationInfo(notification, convertFrameUsing: scrollView) else {
            return
        }
        isKeyboardShowing = true
        delegate?.keyboardWillShow(info: info)
    }

    @objc
    private func handleKeyboardWillHide(notification: Notification) {
        guard let info = KeyboardNotificationInfo(notification, convertFrameUsing: scrollView) else {
            return
        }
        isKeyboardShowing = false
        delegate?.keyboardWillHide(info: info)
    }

    // MARK: - Instance methods
    public func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    public func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
