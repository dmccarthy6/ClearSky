//
//  SearchViewController.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import UIKit

final class SearchViewController: UIViewController {
    private lazy var searchView: SearchView = {
        let searchView = SearchView(delegate: textFieldDelegate)
        searchView.backgroundColor = .systemBackground
        searchView.configureView()
        return searchView
    }()

    var textFieldDelegate: UITextFieldDelegate?

    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

