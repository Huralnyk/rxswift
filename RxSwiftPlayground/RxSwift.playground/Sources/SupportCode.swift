import Foundation

public func exampleOf(description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---\n")
    action()
}
