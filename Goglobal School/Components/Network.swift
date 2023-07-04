//
//  Network.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation
import Apollo
import KeychainSwift
import ApolloSQLite

class Network {
    static let shared = Network()
    private(set) lazy var apollo: ApolloClient = {
        // MARK: Server
        let url = URL(string: "https://sms-endpoint.go-globalschool.com/graphql")!
//        let url = URL(string: "http://localhost:2000/")!
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                             endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

class Network2 {
    static let shared = Network2()
    private(set) lazy var apollo: ApolloClient = {
        // MARK: Server
//        let url = URL(string: "https://sms-endpoint.go-globalschool.com/graphql")!
        let url = URL(string: "http://192.168.2.224:4100/graphql")!
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                            endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            let keychain = KeychainSwift()
            if let token = keychain.get(LoginViewModel.loginKeychainKey) {
                request.addHeader(name: "Authorization", value: token)
            }
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        }
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(TokenAddingInterceptor(), at: 0)
        return interceptors
    }
}
