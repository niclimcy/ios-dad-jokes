//
//  JokesInteractor.swift
//  Dad Jokes
//
//  Created by Nicholas Lim on 30/10/26.
//

class JokesInteractor: JokesInteractorInputProtocol {

    private let jokeStore: JokesStore

    weak var output: JokesInteractorOutputProtocol?

    init(jokeStore: JokesStore) {
        self.jokeStore = JokesStore.shared
    }

    // MARK: - JokesInteractorInputProtocol

    func loadFirstJoke() {
        guard let joke = jokeStore.loadFirstJoke() else { return }
        let isLast = jokeStore.isLast()
        output?.didLoadJoke(joke, isLast: isLast)
    }

    func loadNextJoke() {
        guard let joke = jokeStore.loadNextJoke() else { return }
        let isLast = jokeStore.isLast()
        output?.didLoadJoke(joke, isLast: isLast)
    }
}
