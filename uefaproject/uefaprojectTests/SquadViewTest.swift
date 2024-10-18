//
//  SquadViewTest.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import XCTest
import Combine
@testable import uefaproject

final class SquadViewTests: XCTestCase {

    var viewModel: SquadView.ViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = SquadView.ViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    // Test that ViewModel initializes with default values
    func testViewModelInitialValues() {
        XCTAssertTrue(viewModel.roles.isEmpty, "Initial roles array should be empty")
    }

    // Test successful data fetch
    func testFetchDataSuccess() async throws {
        // Create mock data for successful response
        let mockRoles = [
            Role(name: "Captain", players: []),
            Role(name: "Goalkeeper", players: [])
        ]
        let mockResponse = ClubSquad(squadName: "Test Squad", squadCrest: "", roles: mockRoles, roundNumber: 1)
        let mockData = try! JSONEncoder().encode(mockResponse)
        mockNetworkService.mockData = mockData
        
        // Trigger the data fetch
        await viewModel.fetchData(fileName: "Squad")

        // Use XCTestExpectation to wait for async operations
        let expectation = XCTestExpectation(description: "Fetch data should succeed and update roles")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.roles.count, mockRoles.count, "Roles should be updated from mock data")
            XCTAssertEqual(self.viewModel.roles[0].name, "Captain", "First role should be 'Captain'")
            XCTAssertEqual(self.viewModel.roles[1].name, "Goalkeeper", "Second role should be 'Goalkeeper'")
            expectation.fulfill()
        }

        // Wait for the async expectation to fulfill
        wait(for: [expectation], timeout: 1.0)
    }

    // Test failure case where network request fails
    func testFetchDataFailure() async {
        // Given
        mockNetworkService.mockError = MockError() // Simulate error
        
        // When
        let expectation = XCTestExpectation(description: "Fetch data with error")
        viewModel.$roles
            .dropFirst() // Ignore the initial value
            .sink { roles in
                XCTAssertTrue(roles.isEmpty)
                expectation.fulfill()
            }
        
        await viewModel.fetchData(fileName: "Squad")
        
        // Then
        XCTAssertTrue(viewModel.roles.isEmpty)
    }
}
