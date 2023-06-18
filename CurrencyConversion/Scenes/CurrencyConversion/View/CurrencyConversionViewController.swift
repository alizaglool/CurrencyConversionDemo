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
        bindLoadingToViewModel()
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
        viewModel.baseCurrenciesObservable
            .bind(to: baseCurrencyPickerView.rx.itemTitles) { _, currencyCode in
                return currencyCode
            }
            .disposed(by: disposeBag)
        
        baseCurrencyPickerView.rx.itemSelected
            .subscribe(onNext: { [weak self] (row, _) in
                guard let self = self else { return }
                self.viewModel.baseCurrenciesObservable
                    .filter { !$0.isEmpty }
                    .subscribe(onNext: { [weak self] baseCurrencies in
                        guard let self = self else { return }
                        let baseCurrency = baseCurrencies[row]
                        self.viewModel.baseCurrency.accept(baseCurrency)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind Target Currency Picker View -

extension CurrencyConversionViewController {
    private func bindTargetCurrencyPickerView() {
        //
        viewModel.targetCurrenciesObservable
            .bind(to: targetCurrencyPickerView.rx.itemTitles) { _, currencyCode in
                return currencyCode
            }
            .disposed(by: disposeBag)
        
        targetCurrencyPickerView.rx.itemSelected
            .subscribe(onNext: { [weak self] (row, _) in
                guard let self = self else { return }
                self.viewModel.targetCurrenciesObservable
                    .element(at: row)
                    .subscribe(onNext: { [weak self] targetCurrencies in
                        guard let self = self else { return }
                        let targetCurrency = targetCurrencies[row]
                        self.viewModel.targetCurrency.accept(targetCurrency)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Bind input amount to ViewModel

extension CurrencyConversionViewController {
    private func bindAmountTextFieldToViewModel() {
        //
        amountTextField.keyboardType = .phonePad
        amountTextField.setSecondaryTextField()
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
        swapButton.setPrimaryButton()
        swapButton.rx.tap
            .throttle(RxTimeInterval.microseconds(1000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.viewModel.convertvalueToView()
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - bind Loading To view Model -

extension CurrencyConversionViewController {
    private func bindLoadingToViewModel() {
        viewModel.activityIndicatorStatus
            .subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            Indicator.createIndicator(on: self, start: isLoading)
        }).disposed(by: disposeBag)
    }
}

extension CurrencyConversionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == baseCurrencyPickerView {
            viewModel.baseCurrenciesObservable
                .subscribe(onNext: { [weak self] baseCurrencies in
                    guard let self = self else { return }
                    let baseCurrency = baseCurrencies[row]
                    self.viewModel.baseCurrency.accept(baseCurrency)
                })
                .disposed(by: disposeBag)
        } else if pickerView == targetCurrencyPickerView {
            viewModel.targetCurrenciesObservable
                .subscribe(onNext: { [weak self] targetCurrencies in
                    guard let self = self else { return }
                    let targetCurrency = targetCurrencies[row]
                    self.viewModel.targetCurrency.accept(targetCurrency)
                })
                .disposed(by: disposeBag)
        }
    }
}
