//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Luiz on 6/7/19.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest

struct Meal {
    var name : String
    var calories : Int
}
class w6d5_ui_performance_testingUITests: XCTestCase {

    var app = XCUIApplication()
    var burguer : Meal! = nil
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()

        burguer = Meal(name: "Burguer", calories: 300)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Test Methods


    func testAddMeal() {
        app.navigationBars["Master"].buttons["Add"].tap()
        addMeal(meal: burguer)
    }

    func testShowMealDetail() {
       showMealDetail(meal: burguer)
        app.navigationBars["Detail"].buttons["Master"].tap()
    }

    func testDeleteMeal() {
        deleteMeal(meal: burguer)
    }

//    func testDeleteAllMeals() {
//        deleteAllCell()
//    }
//
//    func testbackScreen() {
//        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Burguer - 300"]/*[[".cells.staticTexts[\"Burguer - 300\"]",".staticTexts[\"Burguer - 300\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//    }

//Mark - Auxiliar Methods
    func deleteMeal(meal: Meal) {
//        let staticText = app.tables.staticTexts["\(meal.name) - \(meal.calories)"]
//        if staticText.exists {
//            staticText.swipeLeft()
//            app.tables.buttons["Delete"].tap()
//        }

        let staticText = app.tables.staticTexts.allElementsBoundByAccessibilityElement

        if let index = staticText.firstIndex(where: { (elt) -> Bool in
            return elt.label == "\(meal.name) - \(meal.calories)"
        }) {
           staticText[index].swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }

    func addMeal(meal: Meal){
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(meal.name)

        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(meal.calories))
        addAMealAlert.buttons["Ok"].tap()

    }

    func showMealDetail(meal : Meal) {

        let staticText = app.tables.staticTexts.allElementsBoundByAccessibilityElement

        if let index = staticText.firstIndex(where: { (elt) -> Bool in
            return elt.label == "\(meal.name) - \(meal.calories)"
        }) {

            staticText[index].tap()
        }
    }

    func deleteAllCell() {
        let staticText = app.tables.staticTexts.allElementsBoundByAccessibilityElement
        while staticText.count > 0 {
            staticText.first?.swipeLeft()

            app.tables.buttons["Delete"].tap()
        }
    }

}


/*
 func testExample() {
 // Use recording to get started writing UI tests.
 // Use XCTAssert and related functions to verify your tests produce the correct results.


 //        let app = XCUIApplication() //Create an object that acts as a proxy to your app (the app being tested). This proxy object represents your entire application so we can use it to get references to the various UI elements on screen.
 app.navigationBars["Master"] //app.navigationBars returns a list of navigation bars within your app. app.navigationBars["Master"] returns the XCUIElement that has the accessibility label "Master". In this case, it'll be main navigation bar of the master view controller.
 .buttons["Add"] //Get a list of all the descendant buttons of the main navigation bar, then return the button that has its accessibility label set to "Add"
 .tap() //Call the .tap() method on the XCUIElement representing the "Add" button in the navigation bar. This effectively simulates the user tapping on this button.

 /*
 Gets a reference to the alert window titled "Add a Meal", then it navigates down the alert's view hierarchy until it gets a reference to the XCUIElement object corresponding to the first UITextField then types the text "Burger" into it.

 As you can see, the view hierarchy for the alert window with two text fields seems complicated. This hierarchy is not something that most developers would know off-hand because its an internal implementation detail of UIAlertController.
 */
 let addAMealAlert = app.alerts["Add a Meal"]
 addAMealAlert.collectionViews.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.tap()
 addAMealAlert.buttons["Ok"].tap()


 }

 */
