//
//  View+Extension.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI


extension View {
    @ViewBuilder
    func BackwardCompatibleScrollView<Content>(onChangedAction: @escaping (() -> Void), content: @escaping () -> Content) -> some View where Content: View {
        if #available(iOS 16.0, *) {
            ScrollView(.vertical, content: content)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .scrollDismissesKeyboard(.immediately)
                .simultaneousGesture(DragGesture().onChanged({ _ in
                    onChangedAction()
                }))
        } else {
            ScrollView(content: content).simultaneousGesture(DragGesture().onChanged({ _ in
                onChangedAction()
            }))
        }
    }
}
