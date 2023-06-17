//
//  CurrencyConversionViewController.swift
//  CurrencyConversion
//
//  Created by Zaghloul on 12/06/2023.
//

import UIKit
import UICurrency
import RxSwift
import RxCocoa
import Networking

class CurrencyConversionViewController: UIViewController {
    
    // MARK: - Outlet -
    
    @IBOutlet private weak var baseCurrencyPickerView: UIPickerView!
    @IBOutlet private weak var targetCurrencyPickerView: UIPickerView!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var convertedValueLabel: UILabel!
    @IBOutlet private weak var swapButton: UIButton!
    
    // MARK: - Variables -
    
    private let viewModel: CurrencyConversionViewModelType
    private let disposeBag = DisposeBag()
    
    // MARK: - Init -
    
    init(viewModel: CurrencyConversionViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        bindBaseCurrencyPickerView()
        bindTargetCurrencyPickerView()
        bindAmountTextFieldToViewModel()
        BindConvertedValueLabelFromViewModel()
        BindSwapButtonWasTapped()
    }

}

// MARK: - Setup PickerView Delegate -

extension CurrencyConversionViewController {
    private func setupPickerView() {
        baseCurrencyPickerView.dataSource = nil
        targetCurrencyPickerView.dataSource = nil
    }
}

// MARK: - Bind Base Currency Picker View -

extension CurrencyConversionViewController {
    private func bindBaseCurrencyPickerView() {
        //
        viewModel.baseCurrencies
            .bind(to: baseCurrencyPickerView.rx.itemTitles) { (_, currency: Currency) -> String? in
                return currency.name
            }
            .disposed(by: disposeBag)
            
        // Bind Selected Values to view Model
        baseCurrencyPickerView.rx.modelSelected(Currency.self)
            .map { (currencies: [Currency]) -> CurrencyModel in
                return CurrencyModel(success: true, symbols: currencies)
            }
            .bind(to: viewModel.baseCurrency)
            .disposed(by: disposeBag)    }
}

// MARK: - Bind Target Currency Picker View -

extension CurrencyConversionViewController {
    private func bindTargetCurrencyPickerView() {
        //
        viewModel.targetCurrencies
            .bind(to: targetCurrencyPickerView.rx.itemTitles) { (_, currency: Currency) -> String? in
                return currency.name
            }
            .disposed(by: disposeBag)
        
        // Bind Selected Values to view Model
        targetCurrencyPickerView.rx.modelSelected(Currency.self)
            .map { (currencies: [Currency]) -> CurrencyModel in
                return CurrencyModel(success: true, symbols: currencies)
            }
            .bind(to: viewModel.targetCurrency)
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind input amount to ViewModel

extension CurrencyConversionViewController {
    private func bindAmountTextFieldToViewModel() {
        //
//        amountTextField.setSecondaryTextField()
        amountTextField.rx.text
            .orEmpty
            .bind(to: viewModel.amount)
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind converted value from ViewModel

extension CurrencyConversionViewController {
    private func BindConvertedValueLabelFromViewModel() {
        //
        viewModel.convertedValue
            .map { String(format: "%.2f", $0) }
            .bind(to: convertedValueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind swap button tap to ViewModel -

extension CurrencyConversionViewController {
    private func BindSwapButtonWasTapped() {
        //
//        swapButton.setPrimaryButton()
        swapButton.rx.tap
            .bind(to: viewModel.swap)
            .disposed(by: disposeBag)
    }
}
