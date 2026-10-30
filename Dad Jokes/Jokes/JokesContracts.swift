//
//  JokesContracts.swift
//  Dad Jokes
//
//  Created by Nicholas Lim on 30/10/26.
//

protocol JokesViewProtocol: AnyObject {
    func showJoke(setup: String, punchline: String, isPunchlineVisible: Bool)
    func showMessage()
}

protocol JokesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapShowPunchline()
    func didTapNext()
}

protocol JokesInteractorInputProtocol: AnyObject {
    func loadFirstJoke()
    func loadNextJoke()
}

protocol JokesInteractorOutputProtocol: AnyObject {
    func didLoadJoke(_ joke: Joke, isLast: Bool)
}
