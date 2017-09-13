import Foundation

public func exampleOf(description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---\n")
    action()
}

public func delay(seconds: Double, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: action)
}
