//
//  UISSScrollViewIndicatorStyleValueConverter.m
//  UISS
//
//  Created by Thomas Elstner on 19.04.17.
//  Copyright © 2017 57things. All rights reserved.
//

#import "UISSScrollViewIndicatorStyleValueConverter.h"

@implementation UISSScrollViewIndicatorStyleValueConverter

- (NSString *)propertyNameSuffix; {
    return @"ScrollViewIndicatorStyle";
}

- (id)init {
    self = [super init];
    if (self) {
        self.stringToValueDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInteger:UIScrollViewIndicatorStyleDefault], @"default",
                                        [NSNumber numberWithInteger:UIScrollViewIndicatorStyleBlack], @"black",
                                        [NSNumber numberWithInteger:UIScrollViewIndicatorStyleWhite], @"white",
                                        nil];
        self.stringToCodeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"UIScrollViewIndicatorStyleDefault", @"default",
                                       @"UIScrollViewIndicatorStyleBlack", @"black",
                                       @"UIScrollViewIndicatorStyleWhite", @"white",
                                       nil];
    }
    return self;
}

@end
