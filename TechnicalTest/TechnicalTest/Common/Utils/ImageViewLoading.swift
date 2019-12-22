//
//  ImageView.swift
//  TechnicalTest
//
//  Created by nbellouni on 20/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

extension UIImageView {

    private static var taskKey = 0
    private static var urlKey = 0

    private var currentTask: URLSessionTask? {
        get { return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var currentURL: URL? {
        get { return objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func loadImageAsync(with urlString: String?) {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        self.addSubview(spinner)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()

        self.image = nil
        
        guard let urlString = urlString else { return }

        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            return
        }

        let url = URL(string: urlString)!
        currentURL = url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTask = nil
            
            DispatchQueue.main.async {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("unable to extract image")
                return
            }

            ImageCache.shared.save(image: downloadedImage, forKey: urlString)

            if url == self?.currentURL {
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                }
            }
        }
        currentTask = task
        task.resume()
    }
}

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()

    static let shared = ImageCache()

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
