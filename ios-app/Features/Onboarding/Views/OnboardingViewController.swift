//
//  OnboardingViewController.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit
import Combine

class OnboardingViewController: BaseViewController {
    private let viewModel: OnboardingViewModel
    weak var coordinator: OnboardingCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let pageControl = UIPageControl()
    private let nextButton = UIButton(type: .system)
    private let skipButton = UIButton(type: .system)
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        // ScrollView
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Page Control
        pageControl.numberOfPages = viewModel.pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .appPrimary
        view.addSubview(pageControl)
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .appPrimary
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        // Skip Button
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.appSecondaryText, for: .normal)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        view.addSubview(skipButton)
        
        setupPages()
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(viewModel.pages.count)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-AppSpacing.md)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-AppSpacing.lg)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
            make.height.equalTo(50)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(AppSpacing.md)
            make.trailing.equalToSuperview().offset(-AppSpacing.md)
        }
    }
    
    override func setupBindings() {
        viewModel.$currentPage
            .sink { [weak self] page in
                guard let self = self else { return }
                self.pageControl.currentPage = page
                let isLastPage = page == self.viewModel.pages.count - 1
                self.nextButton.setTitle(isLastPage ? "Get Started" : "Next", for: .normal)
            }
            .store(in: &cancellables)
    }
    
    private func setupPages() {
        var previousView: UIView?
        
        for (index, page) in viewModel.pages.enumerated() {
            let pageView = createPageView(for: page)
            contentView.addSubview(pageView)
            
            pageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(view.snp.width)
                if let previous = previousView {
                    make.leading.equalTo(previous.snp.trailing)
                } else {
                    make.leading.equalToSuperview()
                }
            }
            
            previousView = pageView
        }
    }
    
    private func createPageView(for page: OnboardingPage) -> UIView {
        let containerView = UIView()
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: page.imageName)
        imageView.tintColor = .appPrimary
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.text = page.title
        titleLabel.font = .appHeading1()
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = page.description
        descriptionLabel.font = .appBody()
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .appSecondaryText
        descriptionLabel.numberOfLines = 0
        containerView.addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-AppSpacing.xl)
            make.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(AppSpacing.xl)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppSpacing.md)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
        }
        
        return containerView
    }
    
    @objc private func nextButtonTapped() {
        if viewModel.isLastPage {
            coordinator?.finishOnboarding()
        } else {
            viewModel.nextPage()
            let offset = CGFloat(viewModel.currentPage) * view.bounds.width
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    @objc private func skipButtonTapped() {
        coordinator?.finishOnboarding()
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        viewModel.currentPage = page
    }
}

