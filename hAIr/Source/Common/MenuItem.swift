import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let role: ButtonRole?      // .destructive 같은 역할이 필요하면
    let action: () -> Void
}
