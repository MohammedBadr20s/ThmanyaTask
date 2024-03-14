//
//  FullScreenPhotoView.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/14/24.
//

import SwiftUI
import Kingfisher

struct FullScreenPhotoView: View {
    @GestureState private var zoom = 1.0
    @State private var isSharePresented: Bool = false

    var photoUrl: URL
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .trailing, content: {
                Spacer()
                Button(action: {
                    isSharePresented = true
                }, label: {
                    Text("Share")
                        .padding(.all, 10)
                })
                KFImage(photoUrl)
                    .placeholder{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                            .scaleEffect(2.0, anchor: .center) // Makes the spinner larger
                            .frame(width: proxy.size.width, height: 150)
                    }
                    .scaledToFit()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .scaleEffect(zoom)
                    .gesture(
                        MagnifyGesture()
                            .updating($zoom) { value, gestureState, transaction in
                                gestureState = value.magnification
                            }
                    )
            })
            
            .sheet(isPresented: $isSharePresented, onDismiss: {
                print("Dismiss: \(isSharePresented)")
            }, content: {
                ActivityViewController(activityItems: [photoUrl])
            })
            
        }
    }
}

#Preview {
    FullScreenPhotoView(photoUrl: URL(string: "Google.com")!)
}
