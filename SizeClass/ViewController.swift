//
//  ViewController.swift
//  SizeClass
//
//  Created by Samantha on 2020/2/19.
//  Copyright © 2020 Samantha. All rights reserved.
//  source: https://www.appcoda.com.tw/size-classes/

import UIKit

class ViewController: UIViewController {
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     
    private lazy var image1: UIImageView = {
        let image1 = UIImageView()
        image1.translatesAutoresizingMaskIntoConstraints = false
        image1.image = UIImage(named: "apple")
        image1.contentMode = .scaleToFill
        return image1
    }()
     
    private lazy var image2: UIImageView = {
        let image2 = UIImageView()
        image2.translatesAutoresizingMaskIntoConstraints = false
        image2.image = UIImage(named: "swift")
        image2.contentMode = .scaleToFill
        return image2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()

        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
     
        super.traitCollectionDidChange(previousTraitCollection)
     
        layoutTrait(traitCollection: traitCollection)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(viewContainer)
        viewContainer.addSubview(image1)
        viewContainer.addSubview(image2)
    }
    
    func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
     
            image1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image1.topAnchor.constraint(equalTo: view.topAnchor),
            image2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
     
        ])
     
        regularConstraints.append(contentsOf: [
            image1.trailingAnchor.constraint(equalTo: image2.leadingAnchor, constant: -10),
            image1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image2.topAnchor.constraint(equalTo: view.topAnchor),
        ])
     
        compactConstraints.append(contentsOf: [
            image1.bottomAnchor.constraint(equalTo: image2.topAnchor, constant: -10),
            image1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image2.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
           // activating shared constraints
           NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }

}

