//
// Copyright (c) 2013 Robert Wijas. All rights reserved.
//

#import "UISSFontValueConverter.h"
#import "UISSFloatValueConverter.h"
#import "UISSArgument.h"
#import "NSArray+UISS.h"

@interface UISSFontValueConverter ()

@property(nonatomic, strong) UISSFloatValueConverter *floatValueConverter;
@property(nonatomic, strong) NSDictionary *fontWeightDict;

@end

@implementation UISSFontValueConverter

- (id)init {
    self = [super init];
    if (self) {
        self.floatValueConverter = [[UISSFloatValueConverter alloc] init];
        self.fontWeightDict = @{  @"ultraLight" : @(UIFontWeightUltraLight),// -0.80
                                  @"thin" : @(UIFontWeightThin),            // -0.60
                                  @"light" : @(UIFontWeightLight),          // -0.40
                                  @"regular" : @(UIFontWeightRegular),      //  0
                                  @"medium" : @(UIFontWeightMedium),        //  0.23
                                  @"semiBold" : @(UIFontWeightSemibold),    //  0.30
                                  @"bold" : @(UIFontWeightBold),            //  0.40
                                  @"heavy" : @(UIFontWeightHeavy)           //  0.56
                               };
    }
    return self;
}

- (BOOL)canConvertValueForArgument:(UISSArgument *)argument {
    return [argument.type hasPrefix:@"@"] && [[argument.name lowercaseString] hasSuffix:@"font"] && [argument.value isKindOfClass:[NSArray class]];
}

- (BOOL)fontFromSelectorString:(NSString *)selectorString fontHandler:(void (^)(UIFont *))fontHandler codeHandler:(void (^)(NSString *))codeHandler fontSize:(CGFloat)fontSize fontWeight:(CGFloat)fontWeight {
    if (![selectorString hasSuffix:@"Font"]) {
        selectorString = [selectorString stringByAppendingString:@"Font"];
    }

    selectorString = [selectorString stringByAppendingString:@"OfSize:"];

    SEL fontSelector = ([selectorString hasPrefix:@"system"]) ? NSSelectorFromString([selectorString stringByAppendingString:@"weight:"]) : NSSelectorFromString(selectorString);

    if ([UIFont respondsToSelector:fontSelector]) {
        if (fontHandler) {
            NSMethodSignature *methodSignature = [UIFont methodSignatureForSelector:fontSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];

            invocation.selector = fontSelector;
            invocation.target = [UIFont class];
            
            [invocation setArgument:&fontSize atIndex:2];
            if([selectorString hasPrefix:@"system"]) {
                [invocation setArgument:&fontWeight atIndex:3];
            }

            [invocation invoke];
            
            __unsafe_unretained UIFont *font = nil;
            [invocation getReturnValue:&font];
            
            fontHandler(font);
        }

        if (codeHandler) {
            if([selectorString hasPrefix:@"system"]) {
                codeHandler([NSString stringWithFormat:@"[UIFont %@%.1f weight:%f]", selectorString, fontSize, fontWeight]);
            } else {
                codeHandler([NSString stringWithFormat:@"[UIFont %@%.1f]", selectorString, fontSize]);
            }
            
        }

        return YES;
    } else {
        return NO;
    }
}

- (BOOL)convertValue:(id)value fontHandler:(void (^)(UIFont *))fontHandler codeHandler:(void (^)(NSString *))codeHandler {
    CGFloat fontSize = [UIFont systemFontSize];
    NSString *fontName = @"system";
    CGFloat fontWeight = UIFontWeightRegular;
    
    if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *) value;

        if (array.count && [array[0] isKindOfClass:[NSString class]]) {
            fontName = array[0];
        } else if (array.count == 1 && [array canConvertToFloatObjectAtIndex:0]) {
            fontSize = [array[0] doubleValue];
        }

        if (array.count == 2 && [array canConvertToFloatObjectAtIndex:1]) {
            fontSize = [array[1] doubleValue];
        }
    }
    
    if ([fontName isEqualToString:@"italic"]) {
        fontName = [fontName stringByAppendingString:@"System"]; // we call "italicSystemFontOfSize:" later
        
    } else if (self.fontWeightDict[fontName]){ // we call "systemFontOfSize:weight:" later
        fontWeight = [self.fontWeightDict[fontName] doubleValue];
        fontName = @"system";
    }
    

    if ([self fontFromSelectorString:fontName fontHandler:fontHandler codeHandler:codeHandler fontSize:fontSize fontWeight:fontWeight]) {
        return YES;
    } else {
        if (fontHandler) {
            fontHandler([UIFont fontWithName:fontName size:fontSize]);
        }
        if (codeHandler) {
            codeHandler([NSString stringWithFormat:@"[UIFont fontWithName:@\"%@\" size:%@]", fontName,
                                                   [self.floatValueConverter generateCodeForFloatValue:fontSize]]);
        }
    }

    return NO;
}

- (id)convertValue:(id)value {
    __block UIFont *result = nil;

    [self convertValue:value
           fontHandler:^(UIFont *font) {
               result = font;
           }
           codeHandler:nil];

    return result;
}

- (NSString *)generateCodeForValue:(id)value {
    __block NSString *result = nil;

    [self convertValue:value fontHandler:nil codeHandler:^(NSString *code) {
        result = code;
    }];

    return result;
}

@end
