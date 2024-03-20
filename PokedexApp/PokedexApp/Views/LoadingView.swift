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
    var loadingView: UIView?
    var loaderMessageLabel: UILabel?

    func generateLoadingView(with customMessage: String?) {
        loader = UIActivityIndicatorView(style: .large)
        loader?.color = UIColor.black
        loader?.startAnimating()
        
        loadingView = UIView()
        loadingView?.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        loadingView?.layer.cornerRadius = 10.0
        
        if let message = customMessage {
            loaderMessageLabel = UILabel()
            loaderMessageLabel?.text = message
            loaderMessageLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
            loaderMessageLabel?.textAlignment = .center
            loaderMessageLabel?.numberOfLines = 0
        }
        
        guard let safeLoader = loader, let safeLoadingView = loadingView else { return }
        
        safeLoadingView.addSubview(safeLoader)
        safeLoader.translatesAutoresizingMaskIntoConstraints = false
        
        safeLoader.centerXAnchor.constraint(equalTo: safeLoadingView.centerXAnchor).isActive = true
        safeLoader.topAnchor.constraint(equalTo: safeLoadingView.topAnchor, constant: 20.0).isActive = true
        
        if loaderMessageLabel != nil {
            loaderMessageLabel?.bottomAnchor.constraint(equalTo: safeLoadingView.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    func displayLoadingView(with customMessage: String?, on superView: UIView) {
        generateLoadingView(with: customMessage)
        
        guard let safeLoadingView = loadingView else { return }
        
        superView.addSubview(safeLoadingView)
        safeLoadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            safeLoadingView.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            safeLoadingView.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            safeLoadingView.widthAnchor.constraint(equalToConstant: 80.0),
            safeLoadingView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    func dismissLoadingView() {
        guard let safeLoader = loader, let safeLoadingView = loadingView else { return }
        safeLoadingView.removeFromSuperview()
        safeLoader.removeFromSuperview()
        
        loader = nil
        loadingView = nil
        loaderMessageLabel = nil
    }
    
}
