import Foundation
import AuthenticationServices

@objc(AuthBrowserModule)
class AuthBrowserModule: NSObject, ASWebAuthenticationPresentationContextProviding {

  private var continuation: CheckedContinuation<String, Error>?
  private var authSession: ASWebAuthenticationSession?

  @objc(openAuth:scheme:resolver:rejecter:)
  func openAuth(
    _ urlString: String,
    scheme: String,
    resolver: @escaping RCTPromiseResolveBlock,
    rejecter: @escaping RCTPromiseRejectBlock
  ) {
    guard let url = URL(string: urlString) else {
      rejecter("ERR_INVALID_URL", "Invalid URL string", nil)
      return
    }

    authSession = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { callbackURL, error in
      if let error = error {
        rejecter("ERR_AUTH_FAILED", "Authentication failed", error)
        return
      }

      guard let callbackURL else {
        rejecter("ERR_NO_CALLBACK", "No callback URL returned", nil)
        return
      }

      resolver(callbackURL.absoluteString)
    }

    authSession?.presentationContextProvider = self
    authSession?.prefersEphemeralWebBrowserSession = false
    authSession?.start()
  }

  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return UIApplication.shared.windows.first ?? ASPresentationAnchor()
  }
}
