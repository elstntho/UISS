//
// Copyright (c) 2013 Robert Wijas. All rights reserved.
//

#import "UISSTextAttributesValueConverter.h"
#import "UISSFontValueConverter.h"
#import "UISSFontTextStyleValueConverter.h"
#import "UISSColorValueConverter.h"
#import "UISSOffsetValueConverter.h"
#import "UISSArgument.h"

@interface UISSTextAttributesValueConverter ()

@property(nonatomic, strong) UISSFontValueConverter *fontConverter;
@property(nonatomic, strong) UISSFontTextStyleValueConverter *fontTextStyleConverter;
@property(nonatomic, strong) UISSColorValueConverter *colorConverter;

@end

@implementation UISSTextAttributesValueConverter

- (id)init
{
    self = [super init];
    if (self) {
        self.fontConverter = [[UISSFontValueConverter alloc] init];
        self.fontTextStyleConverter = [[UISSFontTextStyleValueConverter alloc] init];
        self.colorConverter = [[UISSColorValueConverter alloc] init];
    }
    return self;
}

- (BOOL)canConvertValueForArgument:(UISSArgument *)argument
{
    return [argument.type hasPrefix:@"@"] && [[argument.name lowercaseString] hasSuffix:@"textattributes"] && [argument.value isKindOfClass:[NSDictionary class]];
}

- (void)convertProperty:(NSString *)propertyName fromDictionary:(NSDictionary *)dictionary
           toDictionary:(NSMutableDictionary *)converterDictionary withKey:(NSString *)key
         usingConverter:(id<UISSArgumentValueConverter>)converter;
{
    id value = [dictionary objectForKey:propertyName];
    if (value) {
        id converted = [converter convertValue:value];
        if (converted) {
            [converterDictionary setObject:converted forKey:key];
        }
    }
}

- (id)convertValue:(id)value;
{
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *) value;
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        if ([dictionary[NSFontAttributeName] isKindOfClass:[NSArray class]]) {
            [self convertProperty:UISS_FONT_KEY fromDictionary:dictionary toDictionary:attributes withKey:NSFontAttributeName
                   usingConverter:self.fontConverter];
        } else if ([dictionary[NSFontAttributeName] isKindOfClass:[NSString class]]) {
            [self convertProperty:UISS_FONT_KEY fromDictionary:dictionary toDictionary:attributes withKey:NSFontAttributeName
                   usingConverter:self.fontConverter];
        }
        
        [self convertProperty:UISS_TEXT_COLOR_KEY fromDictionary:dictionary toDictionary:attributes withKey:NSForegroundColorAttributeName
               usingConverter:self.colorConverter];
        
        [self convertProperty:UISS_BACKGROUND_COLOR_KEY fromDictionary:dictionary toDictionary:attributes withKey:NSBackgroundColorAttributeName
               usingConverter:self.colorConverter];
        
        if (attributes.count) {
            return attributes;
        }
    }

    return nil;
}

- (NSString *)generateCodeForValue:(id)value
{
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *) value;

        NSMutableString *objectAndKeys = [NSMutableString string];

        id fontValue = [dictionary objectForKey:UISS_FONT_KEY];
        if (fontValue) {
            [objectAndKeys appendFormat:@"%@, %@,", [self.fontConverter generateCodeForValue:fontValue], @"UITextAttributeFont"];
        }

        id textColorValue = [dictionary objectForKey:UISS_TEXT_COLOR_KEY];
        if (textColorValue) {
            [objectAndKeys appendFormat:@"%@, %@,", [self.colorConverter generateCodeForValue:textColorValue], @"UITextAttributeTextColor"];
        }

        id backgroundColorValue = [dictionary objectForKey:UISS_BACKGROUND_COLOR_KEY];
        if (backgroundColorValue) {
            [objectAndKeys appendFormat:@"%@, %@,", [self.colorConverter generateCodeForValue:backgroundColorValue], @"UITextAttributeBackgroundColor"];
        }

        if (objectAndKeys.length) {
            return [NSString stringWithFormat:@"[NSDictionary dictionaryWithObjectsAndKeys:%@ nil]", objectAndKeys];
        }
    }
    
    return nil;
}

@end
