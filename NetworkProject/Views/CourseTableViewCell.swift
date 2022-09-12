//
//  CourseTableViewCell.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countOfCoursesLabel: UILabel!
    @IBOutlet weak var countOfTestsLabel: UILabel!

    weak var viewModel: CourseViewModelType? {
        willSet {
            guard let viewModel = newValue else { return }
            self.nameLabel.text = viewModel.name
            self.countOfCoursesLabel.text = "Count of lessons: \(viewModel.countOfLessons)"
            self.countOfTestsLabel.text = "Count of tests: \(viewModel.countOfTests)"
            viewModel.fetchImage { [weak self] image in
                DispatchQueue.main.async {
                    self?.courseImageView.image = image
                }
            }
        }
    }
}
