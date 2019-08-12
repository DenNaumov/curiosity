//
//  LoadingViewController.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, LoadingViewAssemblyProtocol {

    var presenter: LoadingViewToPresenterProtocol?
    private var indicator: UIActivityIndicatorView?
    private var errorLabel: UILabel?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.readyToShow()

        indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator?.startAnimating()
        view.addSubview(indicator!)
        indicator?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension LoadingViewController: LoadingPresenterToViewProtocol {

    func showError(_ text: String) {
        indicator?.removeFromSuperview()
        errorLabel = UILabel(frame: .zero)
        errorLabel?.text = text
        errorLabel?.textColor = .white
        view.addSubview(errorLabel!)
        errorLabel?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
