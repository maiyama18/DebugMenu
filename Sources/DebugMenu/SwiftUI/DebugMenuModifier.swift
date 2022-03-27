import Foundation
import SwiftUI

@available(iOSApplicationExtension, unavailable)
struct DebugMenuModifier: ViewModifier {
    internal init(
        debuggerItems: [DebugItem],
        dashboardItems: [DashboardItem],
        options: [Options]
    ) {
        self.debuggerItems = debuggerItems
        self.dashboardItems = dashboardItems
        self.options = options
    }

    let debuggerItems: [DebugItem]
    let dashboardItems: [DashboardItem]
    let options: [Options]

    func body(content: Content) -> some View {
        content.onAppear(perform: {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                DebugMenu.install(
                    windowScene: windowScene,
                    items: debuggerItems,
                    dashboardItems: dashboardItems,
                    options: options
                )
            }
        })
    }
}

@available(iOSApplicationExtension, unavailable)
public extension View {
    @ViewBuilder
    func debugMenu(
        debuggerItems: [DebugItem] = [],
        dashboardItems: [DashboardItem] = [],
        options: [Options] = Options.default,
        enabled: Bool = true
    ) -> some View {
        if enabled {
            modifier(
                DebugMenuModifier(
                    debuggerItems: debuggerItems,
                    dashboardItems: dashboardItems,
                    options: options
                )
            )
        } else {
            self
        }
    }
}
