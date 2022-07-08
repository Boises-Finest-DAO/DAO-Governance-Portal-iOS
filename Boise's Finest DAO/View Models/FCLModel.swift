//
//  FCLModel.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import BigInt
import Combine
import CryptoKit
import FCL
import Flow
import Foundation
import SafariServices
import SwiftUI
import LocalAuthentication

class FCLModel: NSObject, ObservableObject {
    @Published var address: String = ""

    @Published var preAuthz: String = ""

    @Published var provider: Provider = .blocto

    @Published var isShowWeb: Bool = false

    @Published var isPresented: Bool = false

    @Published var accountLookup: String = ""

    @Published var currentObject: String = ""

    @Published var message: String = ""

    @Published var balance: String = ""
    @Published var FUSDBalance: String = ""

    @Published var script: String =
        """
        pub struct SomeStruct {
          pub var x: Int
          pub var y: Int

          init(x: Int, y: Int) {
            self.x = x
            self.y = y
          }
        }

        pub fun main(): [SomeStruct] {
          return [SomeStruct(x: 1, y: 2),
                  SomeStruct(x: 3, y: 4)]
        }
        """

    @Published var transactionScript: String =
        """
           transaction(test: String, testInt: Int) {
               prepare(signer: AuthAccount) {
                    log(signer.address)
                    log(test)
                    log(testInt)
               }
           }
        """

    private var cancellables = Set<AnyCancellable>()
    
    let defaults = UserDefaults.standard

    override init() {
        super.init()
        fcl.config
            .put(.title, value: "Boise's Finest DAO")
            .put(.wallet, value: "https://fcl-discovery.onflow.org/testnet/authn")
            .put(.accessNode, value: "https://access-testnet.onflow.org")
            .put(.authn, value: provider.endpoint)
            .put(.location, value: "https://BoisesFinestDAO.app")
            .put(.env, value: "testnet")
            .put(.scope, value: "email")

        fcl.config
            .put("0xFungibleToken", value: "0xf233dcee88fe0abe")
            .put("0xFUSD", value: "0x3c5959b568896393")
    }

    func changeWallet() {
        fcl.config.put(.authn, value: provider.endpoint)
    }

    func queryFUSD(address: String) {
        fcl.query {
            cadence {
                """
                import FungibleToken from 0xFungibleToken
                import FUSD from 0xFUSD

                pub fun main(account: Address): UFix64 {
                  let receiverRef = getAccount(account).getCapability(/public/fusdBalance)!
                    .borrow<&FUSD.Vault{FungibleToken.Balance}>()

                  return receiverRef!.balance
                }
                """
            }

            arguments {
                [.address(Flow.Address(hex: address))]
            }

            gasLimit {
                1000
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if case let .failure(error) = completion {
                print(error)
            }
        } receiveValue: { block in
            self.FUSDBalance = "\(String(block.fields?.value.toUFix64() ?? 0.0)) FUSD"
        }.store(in: &cancellables)
    }

    func authn() {
        fcl.authenticate()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.address = error.localizedDescription
                }
            } receiveValue: { result in
                self.address = result.address ?? ""
                self.defaults.set(self.address, forKey: "address")
            }.store(in: &cancellables)
    }

    func send() {
        fcl.mutate {
            cadence {
                transactionScript
            }

            arguments {
                [.string("Test2"), .int(1)]
            }

            gasLimit {
                1000
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if case let .failure(error) = completion {
                self.preAuthz = error.localizedDescription
            }
        } receiveValue: { txId in
            self.preAuthz = txId
        }.store(in: &cancellables)
    }

    func authz() {
        fcl.send([
            .transaction(
                """
                   transaction(test: String, testInt: Int) {
                       prepare(signer: AuthAccount) {
                            log(signer.address)
                            log(test)
                            log(testInt)
                       }
                   }
                """
            ),
            .args([.string("Test2"), .int(1)]),
            .limit(1000),
        ])
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if case let .failure(error) = completion {
                self.preAuthz = error.localizedDescription
            }
        } receiveValue: { txId in
            self.preAuthz = txId
        }.store(in: &cancellables)
    }
    
    func faceIdAuth() {
        let context = LAContext()
        var error: NSError?
        let address = defaults.object(forKey: "address") as? String ?? ""

        //Check If Address has been set
        if address != "" {
            // check whether biometric authentication is possible
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "Face ID is used to provide quick access to Web2 Functionality within the app"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // authentication has now completed
                    if success {
                        // authenticated successfully
                        self.address = "123465"
                    } else {
                        // there was a problem
                        self.signOut()
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
    
    func signOut() {
        self.defaults.removeObject(forKey: "address")
        self.address = ""
        fcl.unauthenticate()
    }
}

enum Provider: Int {
    case dapper
    case blocto

    var endpoint: String {
        switch self {
        case .dapper:
            return "https://dapper-http-post.vercel.app/api/authn"
        case .blocto:
            return "https://flow-wallet-testnet.blocto.app/api/flow/authn"
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context _: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_: SFSafariViewController, context _: UIViewControllerRepresentableContext<SafariView>) {}
}
