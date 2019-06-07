//
//  w6d5_ui_performance_testingTests.swift
//  w6d5-ui-performance-testingTests
//
//  Created by Luiz on 6/7/19.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest
@testable import w6d5_ui_performance_testing
import CoreData

class w6d5_ui_performance_testingTests: XCTestCase {

    var sut: MealStorgeManager!


    override func setUp() {

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            PerformanceDataModel.doSomething()
        }
    }

    func testPerformanceCreateDelete() {
        self.measure {
            self.createDeleteMeal()
        }
    }

    //Auxiliar Functions

    func createDeleteMeal() {

        //Given the name & status
        let name = "Lazagna"
        let calories = 300

        //When add todo
        let meal = sut.insertmealItem(name: name, calories: Int64(calories))

        sut.remove(objectID: meal!.objectID)
        sut.save()

    }


    //MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PersistentTodoList", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

}


