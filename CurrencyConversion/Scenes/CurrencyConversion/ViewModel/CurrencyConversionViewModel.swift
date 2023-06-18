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
    var baseCurrenciesObservable: Observable<[String]> { get }
    var targetCurrenciesObservable: Observable<[String]> { get }
    var baseCurrency: BehaviorRelay<String> { get }
    var targetCurrency: BehaviorRelay<String> { get }
    var amount: BehaviorRelay<String> { get }
    var convertedValue: BehaviorSubject<Double> { get }
    var swap: PublishSubject<Void> { get }
    func convertvalueToView()
}

class CurrencyConversionViewModel: CurrencyConversionViewModelType {
    
    private let api: CurrencyAPIProtocol = CurrencyAPI()
    private var baseCurrenciesSubject: PublishSubject = PublishSubject<[String]>()
    private var targetCurrenciesSubject: PublishSubject = PublishSubject<[String]>()
    private var symbols = [Currency]()
    private let disposeBag = DisposeBag()
    var activityIndicatorStatus = BehaviorRelay<Bool>(value: false)
    var baseCurrency = BehaviorRelay<String>(value: "IQD")
    var targetCurrency = BehaviorRelay<String>(value: "EUR")
    var amount = BehaviorRelay<String>(value: "")
    var convertedValue = BehaviorSubject<Double>(value: 0.0)
    var swap = PublishSubject<Void>()
    
    var baseCurrenciesObservable: Observable<[String]>{
        return baseCurrenciesSubject
    }
    
    var targetCurrenciesObservable: Observable<[String]> {
        return targetCurrenciesSubject
    }
    
    init() {
        
        fetchCurrencyData()
    }
    
    
    // MARK: - Get Currency -
    
    func fetchCurrencyData() {
        activityIndicatorStatus.accept(true)
        api.getCurrencyType { [weak self] result in
            guard let self = self else { return }
            self.activityIndicatorStatus.accept(false)
            
            switch result {
            case .success(let response):
                let currencyNames = response?.symbols?.map { $0.key }
                self.baseCurrenciesSubject.onNext(currencyNames ?? [])
                self.targetCurrenciesSubject.onNext(currencyNames ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Convert value to view -
    
    func convertvalueToView() {
        //
        activityIndicatorStatus.accept(true)
    
        api.getConversionAmount(from: baseCurrency.value, to: targetCurrency.value, amount: amount.value) { [weak self] result in
            guard let self = self else { return }
            self.activityIndicatorStatus.accept(false)
            
            switch result {
            case .success(let response):
                guard let response = response?.result else { return }
                self.convertedValue.onNext(response)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

