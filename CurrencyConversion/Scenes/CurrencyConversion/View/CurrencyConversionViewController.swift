//
//  CurrencyConversionViewController.swift
//  CurrencyConversion
//
//  Created by Zaghloul on 12/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyConversionViewController: UIViewController {
    
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
