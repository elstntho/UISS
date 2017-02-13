//
// Copyright (c) 2013 Robert Wijas. All rights reserved.
//

#import "UISS.h"
#import <XCTest/XCTest.h>

@interface ExampleJSONTests : XCTestCase

@property(nonatomic, strong) UISS *uiss;

@end

@implementation ExampleJSONTests

- (void)setUp {
    [super setUp];

    NSString *jsonFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"example" ofType:@"json"];
    self.uiss = [UISS configureWithJSONFilePath:jsonFilePath];
}

- (void)testGeneratedCodeForPad; {
    [self.uiss generateCodeForUserInterfaceIdiom:UIUserInterfaceIdiomPad
                                     codeHandler:^(NSString *code, NSArray *errors) {
                                         XCTAssertTrue(errors.count == 0, @"errors are unexpected");
                                         XCTAssertNotNil(code, nil);
                                         XCTAssertTrue([code rangeOfString:@"[[UINavigationBar appearance] setTintColor:[UIColor greenColor]];"].location != NSNotFound, nil);
                                     }];
}

- (void)testGeneratedCodeForPhone; {
    [self.uiss generateCodeForUserInterfaceIdiom:UIUserInterfaceIdiomPhone
                                     codeHandler:^(NSString *code, NSArray *errors) {
                                         XCTAssertTrue(errors.count == 0, @"errors are unexpected");
                                         XCTAssertNotNil(code, nil);
                                         XCTAssertTrue([code rangeOfString:@"[[UINavigationBar appearance] setTintColor:[UIColor redColor]];"].location != NSNotFound, nil);
                                     }];
}

- (void)testToolbarTintColor; {
    XCTAssertEqualObjects([[UIToolbar appearance] tintColor], [UIColor yellowColor], nil);
}

- (void)testToolbarBackgroundImage; {
    UIImage *backgroundImage = [[UIToolbar appearance] backgroundImageForToolbarPosition:UIToolbarPositionAny
                                                                              barMetrics:UIBarMetricsDefault];
    XCTAssertNotNil(backgroundImage, nil);
    XCTAssertEqualObjects([backgroundImage class], [UIImage class], @"bad property class", nil);
}

- (void)testTabBarItemTitlePositionAdjustment; {
    UIOffset titlePositionAdjustment = [[UITabBarItem appearance] titlePositionAdjustment];
    XCTAssertEqual(titlePositionAdjustment, UIOffsetMake(10, 10), nil);
}

- (void)testNavigationBarTitleVerticalPositionAdjustment; {
    XCTAssertEqual([[UINavigationBar appearance] titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault], 10.0f, nil);
}

- (void)testNavigationBarBackgroundImageForBarMetricsLandscapePhone; {
    XCTAssertNotNil([[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsLandscapePhone], nil);
}

- (void)testTabBarItemTitleTextAttributes; {
    UIFont *font = [[UITabBarItem appearance] titleTextAttributesForState:UIControlStateNormal][UITextAttributeFont];
    XCTAssertNotNil(font, nil);
    if (font) {
        XCTAssertEqualObjects(font, [UIFont systemFontOfSize:24], nil);
    }
}

@end
