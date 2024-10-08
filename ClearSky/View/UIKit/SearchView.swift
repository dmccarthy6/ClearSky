//
//  SearchView.swift
//  ClearSky
//
//  Created by Dylan  on 10/8/24.
//

import UIKit

final class SearchView: UIView {
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter a city name"
        textField.delegate = delegate
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .secondaryLabel
        return textField
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.text = "Provide a city name above to view the current weather."
        label.textAlignment = .center
        return label
    }()

    var delegate: UITextFieldDelegate?

    init(delegate: UITextFieldDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        addSubview(textField)
        addSubview(label)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 50),

            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
