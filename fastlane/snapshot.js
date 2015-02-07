#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();


var target = UIATarget.localTarget();

target.frontMostApp().mainWindow().scrollViews()[0].textFields()[0].textFields()[0].tap();
target.frontMostApp().keyboard().typeString("khwang");
target.frontMostApp().mainWindow().scrollViews()[0].secureTextFields()[0].secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("asdfasdf");
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Sign in"].tap();
captureLocalizedScreenshot('0-games')
target.tap({x:155.00, y:277.50});
captureLocalizedScreenshot('1-detailedgame')
target.frontMostApp().tabBar().buttons()["Graphs"].tap();
target.frontMostApp().mainWindow().tableViews()[0].tapWithOptions({tapOffset:{x:0.23, y:0.26}});
captureLocalizedScreenshot('2-graph')
target.frontMostApp().tabBar().buttons()["News"].tap();
captureLocalizedScreenshot('3-news')

