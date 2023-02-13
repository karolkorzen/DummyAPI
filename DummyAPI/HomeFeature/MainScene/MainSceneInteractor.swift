//
//  MainSceneInteractor.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation
import Combine

public protocol MainSceneInteractor: ObservableObject {
    var isEmpty: Bool { get }
    var isLoading: Bool { get }
    var productViewModels: [ProductItemViewModel] { get }
    var searchQuery: String { get }
    func searchQueryChanged(_ query: String)
}

public final class DefaultMainSceneInteractor: MainSceneInteractor {
    // MARK: Accessible properties
    @Published public var isLoading = true
    @Published public var isEmpty = false
    @Published public var searchQuery = ""
    @Published public var productViewModels: [ProductItemViewModel] = []
    
    // MARK: Private properties
    private var products: [Product] = [] {
        didSet {
            productViewModels = products.map{ ProductItemViewModel($0, priceFormatter: .usdPriceFormatter) }
        }
    }
    private let getProductsUseCase: GetProductsUseCase
    private let searchProductsUseCase: SearchProductsUseCase
    private var searchQueryChangedSignal = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Lifecycle
    public init(
        getProductsUseCase: GetProductsUseCase,
        searchProductsUseCase: SearchProductsUseCase
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        
        setupPipes()
        getProducts()
    }
    
    //MARK: Events
    private func setupPipes() {
        searchQueryChangedSignal
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [unowned self] in
                switch searchQuery.isEmpty {
                case true: getProducts()
                case false: searchProducts(query: searchQuery.lowercased())
                }
            }
            .store(in: &cancellables)
    }
    
    public func searchQueryChanged(_ query: String) {
        guard searchQuery != query else { return }
        searchQuery = query
        searchQueryChangedSignal.send()
    }
}

//MARK: - API Calls
private extension DefaultMainSceneInteractor {
    func getProducts() {
        isLoading = true
        getProductsUseCase.execute()
            .mapResult()
            .sink { [unowned self] result in
                switch result {
                case .success(let products):
                    self.products = products
                case .failure(_):
                    self.products = []
                    #warning("handle error")
                }
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func searchProducts(query: String) {
        isLoading = true
        searchProductsUseCase.execute(input: query)
            .mapResult()
            .sink { [unowned self] result in
                switch result {
                case .success(let products):
                    self.products = products
                case .failure(_):
                    self.products = []
                    #warning("handle error")
                }
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
