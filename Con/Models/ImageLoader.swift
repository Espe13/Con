//
//  ImageLoader.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: Image?
    private var cache = NSCache<NSString, UIImage>()
    private var cancellable: AnyCancellable?
    
    func load(fromURLString urlString: String) {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            self.image = Image(uiImage: cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if let uiImage = $0 {
                    self?.cache.setObject(uiImage, forKey: urlString as NSString)
                    self?.image = Image(uiImage: uiImage)
                }
            }
    }
}

struct PreloadedImageView: View {
    @StateObject private var loader = ImageLoader()
    let imageURL: String
    
    var body: some View {
        Group {
            if let image = loader.image {
                image
                    .resizable()
                    .cornerRadius(15)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
            } else {
                ProgressView()
                    .onAppear { loader.load(fromURLString: imageURL) }
            }
        }
    }
}
