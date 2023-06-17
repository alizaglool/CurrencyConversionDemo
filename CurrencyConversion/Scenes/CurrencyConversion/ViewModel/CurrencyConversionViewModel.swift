//
//  CurrencyConversionViewModel.swift
//  CurrencyConversion
//
//  Created by Zaghloul on 12/06/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Networking

protocol CurrencyConversionViewModelType: AnyObject {
    //
    var activityIndicatorStatus: BehaviorRelay<Bool> { get set }
    var baseCurrencies: Observable<[Currency]> { get }
    var targetCurrencies: Observable<[Currency]> { get }
    var baseCurrency: BehaviorSubject<CurrencyModel?> { get }
    var targetCurrency: BehaviorSubject<CurrencyModel?> { get }
    var amount: BehaviorSubject<String> { get }
    var convertedValue: BehaviorSubject<Double> { get }
    var swap: PublishSubject<Void> { get }
}

class CurrencyConversionViewModel: CurrencyConversionViewModelType {
    
    private let api: CurrencyAPIProtocol = CurrencyAPI()
    var activityIndicatorStatus = BehaviorRelay<Bool>(value: false)
    var baseCurrencies: Observable<[Currency]>
    var targetCurrencies: Observable<[Currency]>
    var baseCurrency = BehaviorSubject<CurrencyModel?>(value: nil)
    var targetCurrency = BehaviorSubject<CurrencyModel?>(value: nil)
    var amount = BehaviorSubject<String>(value: "")
    var convertedValue = BehaviorSubject<Double>(value: 0.0)
    var swap = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.setupCurrencies()
        self.fetchCurrencyData()
        self.setupBindings()
    }
    
    func setupCurrencies() {
        self.baseCurrencies = baseCurrency
            .compactMap { $0?.symbols }
            .map { symbols in
                symbols.map { symbol in
                    Currency(code: symbol.code, name: symbol.name)
                }
            }
            .asObservable()
        
        self.targetCurrencies = targetCurrency
            .compactMap { $0?.symbols }
            .map { symbols in
                symbols.map { symbol in
                    Currency(code: symbol.code, name: symbol.name)
                }
            }
            .asObservable()
    }
    
    // MARK: - Get Currency -
    
    func fetchCurrencyData() {
        activityIndicatorStatus.accept(true)
        api.getCurrencyType { [weak self] result in
            guard let self = self else { return }
            self.activityIndicatorStatus.accept(false)
            
            switch result {
            case .success(let response):
                guard let response = response?.symbols, !response.isEmpty else { return }
                let currencies = CurrencyModel(success: true, symbols: response)
                self.baseCurrency.onNext(currencies)
                self.targetCurrency.onNext(currencies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Calculate converted value based on selected currencies and amount
    
    private func setupBindings() {
        Observable.combineLatest(
            baseCurrency.asObservable(),
            targetCurrency.asObservable(),
            amount.asObservable()
        ) { baseCurrency, targetCurrency, amount in
            guard let base = baseCurrency.value?.symbols()?.first(where: { $0.name == self.baseCurrency.value?.symbols()?.first?.name }) else {
                self.convertedValue.onNext(0.0)
                return
            }
            
            guard let target = targetCurrency.value?.symbols()?.first(where: { $0.name == self.targetCurrency.value?.symbols()?.first?.name }) else { return }
            guard let amountValue = Double(amount) else { return }
            
            if let rate = base.rate {
                let convertedValue = rate * amountValue * (1 / target.rate!)
                self.convertedValue.onNext(convertedValue)
            } else {
               self.api.getExchangeRate(base: base, target: target)
                  .map { rate -> Double in
                     base.rate = rate
                     let convertedValue = rate * amountValue * (1 / target.rate!)
                     return convertedValue
               }.catchErrorJustReturn(0.0)
                .bind(to: self.convertedValue)
                 .disposed(by: self.disposeBag)
           }
        }
        .subscribe(onNext: { [weak self] convertedValue in
              self?.convertedValue.onNext(convertedValue)
        })
        .disposed(by: disposeBag)

       // Rest of your setupBindings() function...
    }
}
