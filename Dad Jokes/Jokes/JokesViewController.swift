//
//  JokesViewController.swift
//  Dad Jokes
//
//  Created by Nicholas Lim on 30/10/26.
//

import UIKit

class JokesViewController: UIViewController {

    var presenter: JokesPresenterProtocol!

    private let stackView = UIStackView()
    private let setupLabel = UILabel()
    private let whatButton = UIButton(type: .system)
    private let punchlineLabel = UILabel()
    private let continueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupGestureRecognizer()

        presenter.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 64
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        setupLabel.font = .preferredFont(forTextStyle: .body)
        setupLabel.textColor = .black
        setupLabel.numberOfLines = 0
        setupLabel.textAlignment = .center
        setupLabel.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.title = "What?"
        config.buttonSize = .large
        whatButton.configuration = config
        whatButton.addTarget(
            self,
            action: #selector(whatButtonPressed),
            for: .touchUpInside
        )

        punchlineLabel.font = .preferredFont(forTextStyle: .body)
        punchlineLabel.textColor = .red
        punchlineLabel.numberOfLines = 0
        punchlineLabel.textAlignment = .center
        punchlineLabel.layer.opacity = 0
        punchlineLabel.translatesAutoresizingMaskIntoConstraints = false

        continueLabel.text = "Tap anywhere for more!"
        continueLabel.font = .preferredFont(forTextStyle: .body)
        continueLabel.textColor = .black
        continueLabel.numberOfLines = 0
        continueLabel.textAlignment = .center
        continueLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(setupLabel)
        stackView.addArrangedSubview(whatButton)
        stackView.addArrangedSubview(punchlineLabel)
        view.addSubview(continueLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            continueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueLabel.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }

    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(showNextJoke)
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func whatButtonPressed() {
        presenter.didTapShowPunchline()
    }

    @objc func showNextJoke() {
        guard punchlineLabel.layer.opacity == 1 else { return }
        presenter.didTapNext()
    }
    
    private func makeAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Dad Survey",
            message: "Did you like the joke?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Yes", style: .default))
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel))
        return alert
    }
}

// MARK: - JokesViewProtocol

extension JokesViewController: JokesViewProtocol {
    func showJoke(setup: String, punchline: String, isPunchlineVisible: Bool) {
        setupLabel.text = setup
        punchlineLabel.text = punchline
        punchlineLabel.layer.opacity = isPunchlineVisible ? 1 : 0
    }
    
    func showMessage() {
        guard presentedViewController == nil else { return }
        present(makeAlert(), animated: true)
    }
}

#Preview {
    JokesRouter.createModule(jokesStore: JokesStore.shared)
}
