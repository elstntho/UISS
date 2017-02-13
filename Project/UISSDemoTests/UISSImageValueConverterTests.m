//
// Copyright (c) 2013 Robert Wijas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UISSImageValueConverter.h"

@interface UISSImageValueConverterTests : XCTestCase

@property(nonatomic, strong) UISSImageValueConverter *converter;

@end

@implementation UISSImageValueConverterTests

- (void)testNullImage; {
    UIImage *image = [self.converter convertValue:[NSNull null]];
    XCTAssertNil(image, nil);

    NSString *code = [self.converter generateCodeForValue:[NSNull null]];
    XCTAssertEqualObjects(code, @"nil", nil);
}

- (void)testSimleImageAsString; {
    UIImage *image = [self.converter convertValue:@"background"];

    XCTAssertNotNil(image, nil);
    XCTAssertEqualObjects(image, [UIImage imageNamed:@"background"], nil);

    NSString *code = [self.converter generateCodeForValue:@"background"];
    XCTAssertEqualObjects(code, @"[UIImage imageNamed:@\"background\"]", nil);
}

- (void)testResizableWithEdgeInsetsDefinedInSubarray; {
    id value = @[@"background", @[@1.0f, @2.0f, @3.0f, @4.0f]];

    UIImage *image = [self.converter convertValue:value];

    XCTAssertNotNil(image, nil);
    XCTAssertEqual(image.capInsets, UIEdgeInsetsMake(1, 2, 3, 4), nil);

    NSString *code = [self.converter generateCodeForValue:value];
    XCTAssertEqualObjects(code, @"[[UIImage imageNamed:@\"background\"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0)]", nil);
}

- (void)testResizableDefinedInOneArray; {
    UIImage *image = [self.converter convertValue:@[@"background", @1.0f, @2.0f, @3.0f, @4.0f]];

    XCTAssertNotNil(image, nil);
    XCTAssertEqual(image.capInsets, UIEdgeInsetsMake(1, 2, 3, 4), nil);
}

- (void)setUp; {
    self.converter = [[UISSImageValueConverter alloc] init];
}

- (void)tearDown; {
    self.converter = nil;
}

@end
