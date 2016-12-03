//
//  GSLTests.m
//  GSLTests
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherManager.h"
#import "ForcastManager.h"

@interface GSLTests : XCTestCase

@end

@implementation GSLTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testWeatherJson {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *jsonUrl = [testBundle URLForResource:@"weather2" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:jsonUrl];
    
    WeatherManager *manager = [WeatherManager new];
    [manager processData:data];
    
    XCTAssertNotNil(manager.todaysWeather);
    XCTAssert(manager.todaysWeather.city.length != 0);
    XCTAssert(manager.todaysWeather.humidity.floatValue != 0.0);
    
}

-(void)testForcastJson {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *jsonUrl = [testBundle URLForResource:@"forcast2" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:jsonUrl];
    
    ForcastManager *manager = [ForcastManager new];
    [manager processData:data];
    
    XCTAssertGreaterThan(manager.count, 0);

    ForcastDay *day1 = [manager forcastForDayAtRow:0];
    ForcastDay *day2 = [manager forcastForDayAtRow:1];
    ForcastDay *day3 = [manager forcastForDayAtRow:2];
    
    XCTAssertNotNil(day1);
    XCTAssertNotNil(day2);
    XCTAssertNotNil(day3);
    
}

@end
