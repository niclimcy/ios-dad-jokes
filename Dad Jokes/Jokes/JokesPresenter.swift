//
//  JokesPresenter.swift
//  Dad Jokes
//
//  Created by Nicholas Lim on 30/10/26.
//

import Foundation

class JokesPresenter: JokesPresenterProtocol, JokesInteractorOutputProtocol {

    weak var view: JokesViewProtocol?
    private let interactor: JokesInteractorInputProtocol

    private var currentJoke: Joke?
    private var isPunchlineVisible = false
    private var pendingAlert: DispatchWorkItem?

    init(view: JokesViewProtocol, interactor: JokesInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func scheduleAlert() {
        cancelAlert()
        let workItem = DispatchWorkItem { [weak self] in
            self?.pendingAlert = nil
            self?.view?.showMessage()
        }
        pendingAlert = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
    }

    private func cancelAlert() {
        pendingAlert?.cancel()
        pendingAlert = nil
    }

    // MARK: - JokesPresenterProtocol

    func viewDidLoad() {
        interactor.loadFirstJoke()
    }

    func didTapShowPunchline() {
        guard let currentJoke else { return }
        self.isPunchlineVisible = true
        view?.showJoke(
            setup: currentJoke.setup,
            punchline: currentJoke.punchline,
            isPunchlineVisible: self.isPunchlineVisible
        )
        scheduleAlert()
    }

    func didTapNext() {
        guard isPunchlineVisible else { return }
        cancelAlert()
        interactor.loadNextJoke()
    }

    // MARK: - JokesInteractorOutputProtocol

    func didLoadJoke(_ joke: Joke, isLast: Bool) {
        self.currentJoke = joke
        self.isPunchlineVisible = false
        view?.showJoke(
            setup: joke.setup,
            punchline: joke.punchline,
            isPunchlineVisible: self.isPunchlineVisible
        )
    }
}
