//
//  ClubScreenViewTest.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import XCTest
import Combine
@testable import uefaproject

// Mock Error
struct MockError: Error {}

final class ClubScreenViewTests: XCTestCase {

    var viewModel: ClubScreenView.ViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = ClubScreenView.ViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    // Test that ViewModel initializes with default values
    func testViewModelInitialValues() {
        XCTAssertEqual(viewModel.squadName, "Barca", "Initial squad name should be 'Barca'")
        XCTAssertEqual(viewModel.roundNumber, 1, "Initial round number should be '1'")
        XCTAssertNotNil(viewModel.squadCrest, "Squad crest should not be nil")
    }

    // Test successful data fetch (ensure we await async call)
    func testFetchDataSuccess() async throws {
        // Create mock data to simulate a successful response
        let mockResponse = ClubSquad(squadName: "Mock Squad", squadCrest: "", roles: [], roundNumber: 10)
        let mockData = try! JSONEncoder().encode(mockResponse)
        mockNetworkService.mockData = mockData
        
        // Trigger the data fetch
        await viewModel.fetchData(fileName: "Squad")

        // Use `XCTestExpectation` to wait for async operations if needed
        let expectation = XCTestExpectation(description: "Fetch data should succeed and update ViewModel")
        
        // Delay checking values until after async updates
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.squadName, "Mock Squad", "Squad name should be updated from mock data")
            XCTAssertEqual(self.viewModel.roundNumber, 10, "Round number should be updated from mock data")
            expectation.fulfill()
        }
        
        // Wait for the async expectation to fulfill
        wait(for: [expectation], timeout: 1.0)
    }

    // Test network failure case
    func testFetchDataFailure() async {
        // Given
        mockNetworkService.mockError = MockError() // Simulate error

        // When
        let expectation = XCTestExpectation(description: "Fetch data with error")
        viewModel.$squadName
            .dropFirst() // Ignore the initial value
            .sink { squadName in
                XCTAssertEqual(squadName, "Barca")
                expectation.fulfill()
            }
        
        await viewModel.fetchData(fileName: "Squad")

        // Then
        XCTAssertEqual(viewModel.roundNumber, 1)
    }
}
