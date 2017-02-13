//
// Copyright (c) 2013 Robert Wijas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UISSBarMetricsValueConverter.h"
#import "UISSControlStateValueConverter.h"
#import "UISSSegmentedControlSegmentValueConverter.h"
#import "UISSToolbarPositionValueConverter.h"
#import "UISSSearchBarIconValueConverter.h"
#import "UISSTextAlignmentValueConverter.h"
#import "UISSImageResizingModeValueConverter.h"

@interface UISSUIKitEnumsValueConvertersTests : XCTestCase

@end

@implementation UISSUIKitEnumsValueConvertersTests

- (void)testBarMetrics {
    UISSBarMetricsValueConverter *converter = [[UISSBarMetricsValueConverter alloc] init];

    XCTAssertEqual([[converter convertValue:@"default"] integerValue], UIBarMetricsDefault, nil);
    XCTAssertEqual([[converter convertValue:@"landscapePhone"] integerValue], UIBarMetricsLandscapePhone, nil);

    XCTAssertNil([converter convertValue:@"dummy"], nil);
}

- (void)testResizingMode {
    UISSImageResizingModeValueConverter *converter = [[UISSImageResizingModeValueConverter alloc] init];

    XCTAssertEqual([[converter convertValue:@"stretch"] integerValue], UIImageResizingModeStretch, nil);
    XCTAssertEqual([[converter convertValue:@"tile"] integerValue], UIImageResizingModeTile, nil);

    XCTAssertNil([converter convertValue:@"dummy"], nil);
}

- (void)testSearchBarIcon {
    UISSSearchBarIconValueConverter *converter = [[UISSSearchBarIconValueConverter alloc] init];

    XCTAssertEqual([[converter convertValue:@"search"] integerValue], UISearchBarIconSearch, nil);
    XCTAssertEqual([[converter convertValue:@"clear"] integerValue], UISearchBarIconClear, nil);
    XCTAssertEqual([[converter convertValue:@"bookmark"] integerValue], UISearchBarIconBookmark, nil);
    XCTAssertEqual([[converter convertValue:@"resultsList"] integerValue], UISearchBarIconResultsList, nil);

    XCTAssertNil([converter convertValue:@"dummy"], nil);
}

- (void)testSegmentedControlSegment {
    UISSSegmentedControlSegmentValueConverter *converter = [[UISSSegmentedControlSegmentValueConverter alloc] init];

    XCTAssertEqual([[converter convertValue:@"any"] integerValue], UISegmentedControlSegmentAny, nil);
    XCTAssertEqual([[converter convertValue:@"left"] integerValue], UISegmentedControlSegmentLeft, nil);
    XCTAssertEqual([[converter convertValue:@"center"] integerValue], UISegmentedControlSegmentCenter, nil);
    XCTAssertEqual([[converter convertValue:@"right"] integerValue], UISegmentedControlSegmentRight, nil);
    XCTAssertEqual([[converter convertValue:@"alone"] integerValue], UISegmentedControlSegmentAlone, nil);

    XCTAssertNil([converter convertValue:@"dummy"], nil);
}

- (void)testTextAlignment {
    UISSTextAlignmentValueConverter *converter = [[UISSTextAlignmentValueConverter alloc] init];

    XCTAssertEqual([[converter convertValue:@"center"] integerValue], NSTextAlignmentCenter, nil);
    XCTAssertEqual([[converter convertValue:@"justified"] integerValue], NSTextAlignmentJustified, nil);
    XCTAssertEqual([[converter convertValue:@"left"] integerValue], NSTextAlignmentLeft, nil);
    XCTAssertEqual([[converter convertValue:@"natural"] integerValue], NSTextAlignmentNatural, nil);
    XCTAssertEqual([[converter convertValue:@"right"] integerValue], NSTextAlignmentRight, nil);

    XCTAssertNil([converter convertValue:@"dummy"], nil);
}

- (void)testToolbarPosition {
    UISSToolbarPositionValueConverter *converter = [[UISSToolbarPositionValueConverter alloc] init];

    XCTAssertEqual([[converter convertValue:@"any"] integerValue], UIToolbarPositionAny, nil);
    XCTAssertEqual([[converter convertValue:@"bottom"] integerValue], UIToolbarPositionBottom, nil);
    XCTAssertEqual([[converter convertValue:@"top"] integerValue], UIToolbarPositionTop, nil);

    XCTAssertNil([converter convertValue:@"dummy"], nil);
}

@end
