//
//  MockHomeVC.swift
//  bookish-appTests
//
//  Created by Mursel Elibol on 2.02.2024.
//

@testable import bookish_app

final class MockHomeVC: HomeVCDelegate {
    
    var invokedconfigureCollectionViewLayout = false
    var invokedconfigureCollectionViewLayoutCount = 0
    
    func configureCollectionViewLayout() {
       invokedconfigureCollectionViewLayout = true
       invokedconfigureCollectionViewLayoutCount += 1
    }
    
    var invokedConfigureCollectionView = false
    var invokedConfigureCollectionViewCount = 0
    
    func configureCollectionView() {
        invokedConfigureCollectionView = true
        invokedConfigureCollectionViewCount += 1
    }
    
    var invokedConstraintCollectionView = false
    var invokedConstraintCollectionViewCount = 0
    
    func constraintCollectionView() {
        invokedConstraintCollectionView = true
        invokedConstraintCollectionViewCount += 1
    }

    var invokedConstraintIndicatorView = false
    var invokedConstraintIndicatorViewCount = 0
    
    func constraintIndicatorView() {
        invokedConstraintIndicatorView = true
        invokedConstraintIndicatorViewCount += 1
    }
    
    var invokedStartLoading = false
    var invokedStartLoadingCount = 0
    
    func startLoading() {
        invokedStartLoading = true
        invokedStartLoadingCount += 1
    }
    
    var invokedStopLoading = false
    var invokedStopLoadingCount = 0
    
    func stopLoading() {
        invokedStopLoading = true
        invokedStopLoadingCount += 1
    }
    
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadCollectionView() {
       invokedReloadData = true
       invokedReloadDataCount += 1
    }
}
