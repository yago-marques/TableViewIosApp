//
//  UIImageView.swift
//  TableViewApp
//
//  Created by Yago Marques on 14/07/23.
//

import UIKit

extension UIImageView {
    func download(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        let request = URLRequest(url: imageUrl)

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.image = UIImage(data: data)
                }
            }
        }

        task.resume()
    }
}
