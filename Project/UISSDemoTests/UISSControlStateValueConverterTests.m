//
// Copyright (c) 2013 Robert Wijas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UISSControlStateValueConverter.h"

@interface UISSControlStateValueConverterTests : XCTestCase

@property(nonatomic, strong) UISSControlStateValueConverter *converter;

@end

@implementation UISSControlStateValueConverterTests

- (void)setUp; {
    self.converter = [[UISSControlStateValueConverter alloc] init];
}

- (void)tearDown; {
    self.converter = nil;
}

- (void)testControlStateNormal {
    XCTAssertEqual([[self.converter convertValue:@"normal"] unsignedIntegerValue], (UIControlState) UIControlStateNormal, nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"normal"], @"UIControlStateNormal", nil);
}

- (void)testControlStateHighlighted {
    XCTAssertEqual([[self.converter convertValue:@"highlighted"] unsignedIntegerValue], (UIControlState) UIControlStateHighlighted, nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"highlighted"], @"UIControlStateHighlighted", nil);
}

- (void)testControlStateDisabled {
    XCTAssertEqual([[self.converter convertValue:@"disabled"] unsignedIntegerValue], (UIControlState) UIControlStateDisabled, nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"disabled"], @"UIControlStateDisabled", nil);
}

- (void)testControlStateSelected {
    XCTAssertEqual([[self.converter convertValue:@"selected"] unsignedIntegerValue], (UIControlState) UIControlStateSelected, nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"selected"], @"UIControlStateSelected", nil);
}

- (void)testControlStateApplication {
    XCTAssertEqual([[self.converter convertValue:@"application"] unsignedIntegerValue], (UIControlState) UIControlStateApplication, nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"application"], @"UIControlStateApplication", nil);
}

- (void)testControlStateReserved {
    XCTAssertEqual([[self.converter convertValue:@"reserved"] unsignedIntegerValue], (UIControlState) UIControlStateReserved, nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"reserved"], @"UIControlStateReserved", nil);
}

- (void)testInvalidValue {
    XCTAssertNil([self.converter convertValue:@"dummy"], nil);
    XCTAssertNil([self.converter generateCodeForValue:@"dummy"], nil);
}

- (void)testControlStateSelectedAndHighlighted {
    XCTAssertEqual([[self.converter convertValue:@"selected|highlighted"] unsignedIntegerValue], (UIControlState) (UIControlStateSelected | UIControlStateHighlighted), nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"selected|highlighted"], @"UIControlStateSelected|UIControlStateHighlighted", nil);
}

- (void)testControlStateNormalAndHighlighted {
    XCTAssertEqual([[self.converter convertValue:@"normal|highlighted"] unsignedIntegerValue], (UIControlState) (UIControlStateNormal | UIControlStateHighlighted), nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"normal|highlighted"], @"UIControlStateNormal|UIControlStateHighlighted", nil);
}

- (void)testControlStateDisabledAndSelected {
    XCTAssertEqual([[self.converter convertValue:@"disabled|selected"] unsignedIntegerValue], (UIControlState) (UIControlStateDisabled | UIControlStateSelected), nil);
    XCTAssertEqualObjects([self.converter generateCodeForValue:@"disabled|selected"], @"UIControlStateDisabled|UIControlStateSelected", nil);
}

@end
