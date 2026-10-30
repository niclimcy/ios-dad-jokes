//
//  JokesStore.swift
//  Dad Jokes
//
//  Created by Nicholas Lim on 30/10/26.
//

class JokesStore {
    static let shared = JokesStore()

    private var idx = 0

    private(set) var jokes = [
        Joke(
            setup: "Why don't scientists trust atoms?",
            punchline: "Because they make up everything!"
        ),
        Joke(
            setup: "Why did the scarecrow win an award?",
            punchline: "He was outstanding in his field!"
        ),
        Joke(
            setup: "What do you call a fake noodle?",
            punchline: "An impasta!"
        ),
    ]

    func loadFirstJoke() -> Joke? {
        guard !jokes.isEmpty else { return nil }
        idx = 0
        return jokes.first
    }

    func loadNextJoke() -> Joke? {
        guard idx + 1 < jokes.count else { return nil }
        idx += 1
        return jokes[idx]
    }

    func isLast() -> Bool {
        idx + 1 == jokes.count
    }

    func restartJokes() {
        idx = 0
    }
}
