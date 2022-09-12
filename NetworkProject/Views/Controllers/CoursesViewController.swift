//
//  CourseViewController.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import UIKit

class CoursesViewController: UIViewController {
    private var coursesViewModel: CoursesViewModelType = CoursesViewModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Courses"
        coursesViewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        fetchCoursesData()
    }

    private func fetchCoursesData() {
        coursesViewModel.fetchCourses(from: StringUrl.courses.rawValue)
        NetworkSession.network.fetchCourses(from: StringUrl.courses.rawValue) { courses in
            print(courses)
        }
    }

    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailWebView" {
            if let detailWebViewVC = segue.destination as? DetailCourseWebViewViewController,
                let course = coursesViewModel.selectedCourse {
                detailWebViewVC.courseVideModel = CourseViewModel(course: course)
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesViewModel.countCourse()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CourseTableViewCell else { return UITableViewCell() }
        cell.viewModel = coursesViewModel.courseViewModel(from: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coursesViewModel.setSelectedItem(from: indexPath)
        performSegue(withIdentifier: "detailWebView", sender: self)
    }
}

//MARK: - RequestDelegateType

extension CoursesViewController: RequestDelegateType {
    func didUpdate() {
        tableView.reloadData()
        activityIndicatorView.isHidden = true
    }
}
