#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

target.frontMostApp().mainWindow().scrollViews()[0].images()["login_background.jpg"].textFields()[0].textFields()[0].tap();
target.frontMostApp().keyboard().typeString("khwang");
target.frontMostApp().mainWindow().scrollViews()[0].images()["login_background.jpg"].secureTextFields()[0].secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("asdfasdf");
target.frontMostApp().mainWindow().scrollViews()[0].images()["login_background.jpg"].buttons()["Sign in"].tap();
target.delay(5);
captureLocalizedScreenshot('0-games');
target.tap({x:148.50, y:213.50});
target.delay(5);
captureLocalizedScreenshot('1-detailedgame');
target.frontMostApp().tabBar().buttons()["Graphs"].tap();
target.delay(5);
captureLocalizedScreenshot('2-graph');
target.frontMostApp().tabBar().buttons()["News"].tap();
target.delay(5);
captureLocalizedScreenshot('3-news');
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.delay(5);
captureLocalizedScreenshot('4-settings');

