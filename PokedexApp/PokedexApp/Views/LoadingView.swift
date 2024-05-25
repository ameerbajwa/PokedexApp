//
//  LoadingView.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/19/24.
//

import Foundation
import UIKit

class LoadingView: UIView {
    var loader: UIActivityIndicatorView?
    var loaderMessageLabel: UILabel?

    func generateLoadingView(with customMessage: String?) {
        loader = UIActivityIndicatorView(style: .large)
        loader?.color = UIColor.black
        loader?.startAnimating()
        
        self.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        self.layer.cornerRadius = 10.0
        
        if let message = customMessage {
            loaderMessageLabel = UILabel()
            loaderMessageLabel?.text = message
            loaderMessageLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
            loaderMessageLabel?.textAlignment = .center
            loaderMessageLabel?.numberOfLines = 0
        }
        
        guard let safeLoader = loader else { return }
        
        self.addSubview(safeLoader)
        safeLoader.translatesAutoresizingMaskIntoConstraints = false
        
        safeLoader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        guard let safeLoaderMessageLabel = loaderMessageLabel else {
            safeLoader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            return
        }
        
        self.addSubview(safeLoaderMessageLabel)
        safeLoaderMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        safeLoader.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0).isActive = true
        safeLoaderMessageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
        safeLoaderMessageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
        safeLoaderMessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    func displayLoadingView(with customMessage: String?, on superView: UIView) {
        generateLoadingView(with: customMessage)
                
        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: 80.0),
            self.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    func dismissLoadingView() {
        guard let safeLoader = loader else { return }
        self.removeFromSuperview()
        safeLoader.removeFromSuperview()
        
        loader = nil
        loaderMessageLabel = nil
    }
    
}
