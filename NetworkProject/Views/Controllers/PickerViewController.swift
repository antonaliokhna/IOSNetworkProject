//
//  PickerViewController.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import UIKit

class PickerViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Shoose network type"
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        pickerView.selectRow(NetworkSession.allCases.firstIndex(of: NetworkSession.shared)!, inComponent: 0, animated: true)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NetworkSession.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NetworkSession.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NetworkSession.shared = NetworkSession.allCases[row]
    }
}
