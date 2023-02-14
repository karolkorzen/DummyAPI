//
//  MainSceneInteractor.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation
import Combine
import CoreUseCases
import CoreModels

public protocol MainSceneInteractor: ObservableObject {
    var isEmpty: Bool { get }
    var isLoading: Bool { get }
    var productViewModels: [ProductItemViewModel] { get }
    var errorMessage: String? { get }
    var searchQuery: String { get }
    func searchQueryChanged(_ query: String)
    func errorMessageDismissed()
}

public final class DefaultMainSceneInteractor: MainSceneInteractor {
    // MARK: Accessible properties
    @Published public var isLoading = true
    @Published public var isEmpty = false
    @Published public var searchQuery = ""
    @Published public var productViewModels: [ProductItemViewModel] = []
    @Published public var errorMessage: String? = nil
    
    // MARK: Private properties
    private var products: [Product] = [] {
        didSet {
            productViewModels = products.map{ ProductItemViewModel($0, priceFormatter: .usdPriceFormatter) }
            isEmpty = productViewModels.isEmpty
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
    
    public func errorMessageDismissed() {
        errorMessage = nil
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
                case .failure(let error):
                    self.products = []
                    self.errorMessage = error.localizedDescription
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
                case .failure(let error):
                    self.products = []
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
