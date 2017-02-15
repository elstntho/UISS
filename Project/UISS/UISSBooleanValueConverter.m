//
//  UISSBooleanValueConverter.m
//  UISS
//
//  Created by Thomas Elstner on 15.02.17.
//  Copyright © 2017 57things. All rights reserved.
//

#import "UISSBooleanValueConverter.h"
#import "UISSArgument.h"

@implementation UISSBooleanValueConverter

- (BOOL)canConvertValueForArgument:(UISSArgument *)argument
{
    return [argument.type isEqualToString:[NSString stringWithCString:@encode(BOOL) encoding:NSUTF8StringEncoding]];
}

- (id)convertValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        BOOL boolValue = [value boolValue];
        return [NSValue value:&boolValue withObjCType:@encode(BOOL)];
    }
    
    return nil;
}

- (NSString *)generateCodeForValue:(id)value
{
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue] ? @"YES" : @"NO";
    }
    
    return nil;
}

@end
