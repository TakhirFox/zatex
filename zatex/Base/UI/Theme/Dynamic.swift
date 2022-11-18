import Foundation

public struct Listener<T> {
    public typealias Value = (new: T, old: T)
    public typealias Action = (Value) -> Void
    
    let action: Action
    var skip: Int
    
    public init(action: @escaping Action, skip: Int = 0) {
        self.action = action
        self.skip = skip
    }
}

private func pointer(_ objRef: AnyObject) -> String {
    let ptr: OpaquePointer = OpaquePointer(Unmanaged<AnyObject>.passUnretained(objRef).toOpaque())
    return String(describing: ptr)
}

public class Dynamic<T> {
    public typealias Value = (new: T, old: T)
    public typealias ListenerAction = (Value) -> Void
    
    // MARK: - Properties
    
    private var observers: [String] = []
    private var listeners: [Listener<T>] = []
    
    public var value: T {
        didSet {
            for var listener in listeners {
                if listener.skip == 0 {
                    listener.action((new: value, old: oldValue))
                } else {
                    listener.skip -= 1
                }
            }
        }
    }
    
    var listenersCount: Int {
        return listeners.count
    }
    
    // MARK: - Init
    
    public init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Public Functions
    
    /// Signatures for changing value. Skip allows you to skip calls.
    public func bind(_ observer: AnyObject, skip: Int = 0, action: @escaping ListenerAction) {
        let listener = Listener(action: action, skip: skip)
        observers.append(pointer(observer))
        listeners.append(listener)
    }
    
    /// Signature to change value and immediately call action. Skip allows you to skip calls.
    public func bindAndFire(_ observer: AnyObject, skip: Int = 0, action: @escaping ListenerAction) {
        bind(observer, skip: skip, action: action)
        action((new: value, old: value))
    }
    
    /// Unsubscribe from value changes
    public func unbind(_ observer: AnyObject) {
        let index = observers.firstIndex(of: pointer(observer))
        
        if let index = index {
            listeners.remove(at: index)
            observers.remove(at: index)
        }
    }
}
