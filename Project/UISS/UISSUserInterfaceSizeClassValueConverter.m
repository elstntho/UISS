//
//  UISSUserInterfaceSizeClassValueConverter.m
//  UISS
//
//  Created by Thomas Elstner on 10.02.17.
//  Copyright © 2017 57things. All rights reserved.
//

#import "UISSUserInterfaceSizeClassValueConverter.h"

@implementation UISSUserInterfaceSizeClassValueConverter


- (NSString *)propertyNameSuffix; {
    return @"UserInterfaceSizeClass";
}

- (id)init {
    self = [super init];
    if (self) {
        self.stringToValueDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInteger:UIUserInterfaceSizeClassUnspecified], @"unspecified",
                                        [NSNumber numberWithInteger:UIUserInterfaceSizeClassCompact], @"compact",
                                        [NSNumber numberWithInteger:UIUserInterfaceSizeClassRegular], @"regular",
                                        nil];
        self.stringToCodeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"UIUserInterfaceSizeClassUnspecified", @"unspecified",
                                       @"UIUserInterfaceSizeClassCompact", @"compact",
                                       @"UIUserInterfaceSizeClassRegular", @"regular",
                                       nil];
    }
    return self;
}

@end
