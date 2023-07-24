//
//  UsersListTests.swift
//  UsersListTests
//
//  Created by Breno Morais on 22/07/23.
//

import XCTest
@testable import UsersList

class UsersListServiceProtocolMock: UsersListService {
    var jsonMock = ""
    
    override func getUsersList(params: UsersListRequest, callback: @escaping (Bool, UsersListResponse?) -> ()) {
        if let responseMock = JSONHandler().readJson(type: UsersListResponse.self, fileName: self.jsonMock) {
            callback(true, responseMock)
            
        } else {
            callback(false, nil)
        }
    }
}

 class UsersListTests: XCTestCase, UsersListCoordinatorProtocol {
    
    var viewModel: UsersListViewModel? = nil
    let service = UsersListServiceProtocolMock()
    var users: [UsersList] = []
    var didCallLoading: Bool = false
    var didCallEmpty: Bool = false
    var didCallError: Bool = false
    var errorMsg: String = ""
     
    override func setUp() {
        
        self.viewModel = UsersListViewModel(delegate: self, service: service)
        self.loadListener()
    }
     
     private func loadListener() {
         viewModel?.viewState.bind({ [weak self] viewState in
             guard let viewState = viewState else {
                 return
             }
             
             DispatchQueue.main.async {
                 switch viewState {
                 case .Loading:
                     self?.didCallLoading = true
                 case .Empty:
                     self?.didCallEmpty = true
                 case .Error(let msg):
                     self?.didCallError = true
                     self?.errorMsg = msg
                 case .Data(let users):
                     self?.users = users
                 }
             }
         })
     }

    func testClassInitializers() {
        XCTAssertNotNil(self.viewModel)
    }
     
     func testNormalCase() {
         self.service.jsonMock = "UsersListJson"
         self.viewModel?.loadUsersList()
         
         let exp = expectation(description: "wait for change view status")
         let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
         if result == XCTWaiter.Result.timedOut {
             XCTAssertTrue(self.didCallLoading)
             XCTAssertEqual(self.users.count, 6)
         } else {
             XCTFail("Fail")
         }
     }
     
     func testEmptyCase() {
         self.service.jsonMock = "EmpryUsersListJson"
         self.viewModel?.loadUsersList()
         
         let exp = expectation(description: "wait for change view status")
         let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
         if result == XCTWaiter.Result.timedOut {
             XCTAssertTrue(self.didCallEmpty)
             XCTAssertEqual(self.users.count, 0)
         } else {
             XCTFail("Fail")
         }
     }
     
     func testErrorCase() {
         self.service.jsonMock = "ErrorUsersListJson"
         self.viewModel?.loadUsersList()
         
         let exp = expectation(description: "wait for change view status")
         let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
         if result == XCTWaiter.Result.timedOut {
             XCTAssertTrue(self.didCallError)
             XCTAssertEqual(self.errorMsg, "An error has occurred.\nTry again later.")
         } else {
             XCTFail("Fail")
         }
     }
}


