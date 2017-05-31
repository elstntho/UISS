//
//  UISSFontTextStyleValueConverter.m
//  UISS
//
//  Created by Thomas Elstner on 22.02.17.
//  Copyright (c) 2017 Deutsche Telekom Clinical Solutions GmbH. All rights reserved.
//

#import "UISSFontTextStyleValueConverter.h"
#import "UISSFloatValueConverter.h"
#import "UISSArgument.h"
#import "NSArray+UISS.h"

@interface UISSFontTextStyleValueConverter ()
@property(nonatomic, strong) NSDictionary <NSString*, UIFontTextStyle> *fontTextStyleValueDict;
@property(nonatomic, strong) NSDictionary *fontTextStyleCodeDict;
@end

@implementation UISSFontTextStyleValueConverter

- (id)init {
    self = [super init];
    if (self) {
        self.fontTextStyleValueDict = @{
                                        @"title1": UIFontTextStyleTitle1,
                                        @"title2": UIFontTextStyleTitle2,
                                        @"title3": UIFontTextStyleTitle3,
                                        @"headline": UIFontTextStyleHeadline,
                                        @"subheadline": UIFontTextStyleSubheadline,
                                        @"body": UIFontTextStyleBody,
                                        @"callout": UIFontTextStyleCallout,
                                        @"footnote": UIFontTextStyleFootnote,
                                        @"caption1": UIFontTextStyleCaption1,
                                        @"caption2": UIFontTextStyleCaption2,
                                        };
        self.fontTextStyleCodeDict = @{
                                       @"title1": @"UIFontTextStyleTitle1",
                                       @"title2": @"UIFontTextStyleTitle2",
                                       @"title3": @"UIFontTextStyleTitle3",
                                       @"headline": @"UIFontTextStyleHeadline",
                                       @"subheadline": @"UIFontTextStyleSubheadline",
                                       @"body": @"UIFontTextStyleBody",
                                       @"callout": @"UIFontTextStyleCallout",
                                       @"footnote": @"UIFontTextStyleFootnote",
                                       @"caption1": @"UIFontTextStyleCaption1",
                                       @"caption2": @"UIFontTextStyleCaption2",
                                       };
    }
    return self;
}

- (BOOL)canConvertValueForArgument:(UISSArgument *)argument {
    return [argument.type hasPrefix:@"@"] && [[argument.name lowercaseString] hasSuffix:@"font"]  && [argument.value isKindOfClass:[NSString class]];
}

- (id)convertValue:(id)value {
    UIFontTextStyle fontTextStyle = self.fontTextStyleValueDict[[value lowercaseString]];
    if (!fontTextStyle) {
        fontTextStyle = UIFontTextStyleBody;
    }
    
    UIFont *result = [UIFont preferredFontForTextStyle:fontTextStyle];
    return result;
}

- (NSString *)generateCodeForValue:(id)value {
    NSString *fontTextStyleCode = self.fontTextStyleCodeDict[[value lowercaseString]];
    if (!fontTextStyleCode) {
        fontTextStyleCode = self.fontTextStyleCodeDict[@"body"];
    }
    NSString *result = [NSString stringWithFormat:@"[UIFont preferredFontForTextStyle:%@]", fontTextStyleCode];
    return result;
}

@end
