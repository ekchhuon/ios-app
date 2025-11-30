//
//  OnboardingViewModel.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Combine

class OnboardingViewModel: BaseViewModel {
    @Published var currentPage: Int = 0
    @Published var pages: [OnboardingPage] = []
    
    override init() {
        super.init()
        loadPages()
    }
    
    private func loadPages() {
        pages = [
            OnboardingPage(
                title: "Welcome",
                description: "Welcome to our amazing app",
                imageName: "star.fill"
            ),
            OnboardingPage(
                title: "Features",
                description: "Discover amazing features",
                imageName: "heart.fill"
            ),
            OnboardingPage(
                title: "Get Started",
                description: "Start your journey today",
                imageName: "rocket.fill"
            )
        ]
    }
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            currentPage += 1
        }
    }
    
    func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    var isLastPage: Bool {
        return currentPage == pages.count - 1
    }
}

