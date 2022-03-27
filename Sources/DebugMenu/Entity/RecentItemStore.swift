import Foundation

struct RecentItemStore {
    let key: String = "dev.noppe.debugmenu.recent-item-names"
    let items: [AnyDebugItem]
    let maxCount: Int = 3

    func get() -> [AnyDebugItem] {
        let titles = UserDefaults.standard.stringArray(forKey: key)?.prefix(maxCount) ?? []
        return titles.compactMap({ title in items.first(where: { $0.debugItemTitle == title }) })
            .map(AnyDebugItem.init)
    }

    func insert(_ item: AnyDebugItem) {
        var titles = UserDefaults.standard.stringArray(forKey: key) ?? []
        titles.removeAll(where: { $0 == item.debugItemTitle })
        titles.insert(item.debugItemTitle, at: 0)
        UserDefaults.standard.set(titles.prefix(maxCount).map({ $0 }), forKey: key)
    }
}
