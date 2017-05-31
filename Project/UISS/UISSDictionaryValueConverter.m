//
//  UISSDictionaryValueConverter.m
//  UISS
//
//  Created by Thomas Elstner on 13.03.17.
//  Copyright © 2017 57things. All rights reserved.
//

#import "UISSDictionaryValueConverter.h"
#import "UISSArgument.h"
#import "UISSProperty.h"
#import "UISSPropertySetter.h"
@interface UISSDictionaryValueConverter ()
@property (nonatomic, weak) UISSArgument *argument;
@end

@implementation UISSDictionaryValueConverter

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)canConvertValueForArgument:(UISSArgument *)argument
{
    BOOL result = [argument.type hasPrefix:@"@"] && ![[argument.name lowercaseString] hasSuffix:@"textattributes"] && [argument.value isKindOfClass:[NSDictionary class]];
    if (result) {
        self.argument = argument;
    }
    return result;
}

- (id)convertValue:(id)value;
{
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *) value;
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

        for (NSString *key in dictionary.allKeys) {
            
            UISSPropertySetter *propertySetter = [[UISSPropertySetter alloc] init];
            propertySetter.group = self.argument.propertySetter.group;
            propertySetter.appearanceClass = self.argument.propertySetter.appearanceClass;
            UISSProperty *property = [[UISSProperty alloc] init];
            property.name = key;
            property.value = dictionary[key];
            
            propertySetter.property = property;
            attributes[key] = [propertySetter.property convertedValue];
        }
        
        if (attributes.count) {
            return attributes;
        }
    }
    
    return nil;
}

- (NSString *)generateCodeForValue:(id)value {
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *) value;
        NSMutableString *objectAndKeys = [NSMutableString string];

        for (NSString *key in dictionary.allKeys) {
            UISSPropertySetter *propertySetter = [[UISSPropertySetter alloc] init];
            propertySetter.group = self.argument.propertySetter.group;
            propertySetter.appearanceClass = self.argument.propertySetter.appearanceClass;
            UISSProperty *property = [[UISSProperty alloc] init];
            property.name = key;
            property.value = dictionary[key];
            propertySetter.property = property;
            [objectAndKeys appendFormat:@"%@, \"%@\", ", [propertySetter.property generatedCode], key];

        }
        if (objectAndKeys.length) {
            return [NSString stringWithFormat:@"[NSDictionary dictionaryWithObjectsAndKeys:%@ nil]", objectAndKeys];
        }
    }
    
    return nil;
}

@end
