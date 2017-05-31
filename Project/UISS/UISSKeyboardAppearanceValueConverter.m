//
//  UISSKeyboardAppearanceValueConverter.m
//  UISS
//
//  Created by Thomas Elstner on 20.03.17.
//  Copyright (c) 2017 Deutsche Telekom Clinical Solutions GmbH. All rights reserved.
//

#import "UISSKeyboardAppearanceValueConverter.h"

@implementation UISSKeyboardAppearanceValueConverter

- (NSString *)propertyNameSuffix; {
    return @"KeyboardAppearance";
}

- (id)init {
    self = [super init];
    if (self) {
        self.stringToValueDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInteger:UIKeyboardAppearanceDefault], @"default",
                                        [NSNumber numberWithInteger:UIKeyboardAppearanceDark], @"dark",
                                        [NSNumber numberWithInteger:UIKeyboardAppearanceLight], @"light",
                                        [NSNumber numberWithInteger:UIKeyboardAppearanceAlert], @"alert",
                                        nil];
        self.stringToCodeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"UIKeyboardAppearanceDefault", @"default",
                                       @"UIKeyboardAppearanceDark", @"dark",
                                       @"UIKeyboardAppearanceLight", @"light",
                                       @"UIKeyboardAppearanceAlert", @"alert",
                                       nil];
    }
    return self;
}

@end
