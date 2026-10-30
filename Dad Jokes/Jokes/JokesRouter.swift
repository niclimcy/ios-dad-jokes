//
//  JokesRouter.swift
//  Dad Jokes
//
//  Created by Nicholas Lim on 30/10/26.
//

import UIKit

@MainActor
class JokesRouter {

    weak var viewController: UIViewController?

    static func createModule(jokesStore: JokesStore) -> UIViewController {
        let view = JokesViewController()
        let interactor = JokesInteractor(jokeStore: jokesStore)
        let router = JokesRouter()
        let presenter = JokesPresenter(view: view, interactor: interactor)

        view.presenter = presenter      // view -> presenter (strong)
        interactor.output = presenter   // interactor -> presenter (weak)
        router.viewController = view    // router -> view (weak)

        return view
    }
}
