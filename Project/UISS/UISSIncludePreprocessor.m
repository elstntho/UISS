//
//  UISSIncludePreprocessor.m
//  UISS
//
//  Created by Thomas Elstner on 03.03.17.
//  Copyright © 2017 57things. All rights reserved.
//

#import "UISSIncludePreprocessor.h"

@implementation UISSIncludePreprocessor

- (id)preprocessValueIfNecessary:(id)value baseUrl:(NSURL *)baseUrl
{
    if ([value isKindOfClass:[NSDictionary class]]) {
        return [self preprocess:value userInterfaceIdiom:UIUserInterfaceIdiomUnspecified baseUrl:baseUrl];
    } else {
        return value;
    }
}

- (NSDictionary *)preprocess:(NSDictionary *)dictionary userInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom baseUrl:(NSURL *)baseUrl {
    NSMutableDictionary *preprocessed = [NSMutableDictionary dictionary];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id object, BOOL *stop) {
        if ([key isEqualToString:@"..."] && [object isKindOfClass:[NSString class]]) {
            NSError *error;
            NSURL *includeUrl = nil;
            if (baseUrl.fileURL) {
                includeUrl = [baseUrl URLByAppendingPathComponent:(NSString *)object];
            } else {
                includeUrl = [NSURL URLWithString:(NSString *)object relativeToURL:baseUrl];
            }
            NSData *data = [NSData dataWithContentsOfURL:includeUrl
                                                 options:(NSDataReadingOptions) 0
                                                   error:&error];
            if (!error) {
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:&error];
                if (!error && dictionary) {
                    [preprocessed addEntriesFromDictionary:[self preprocessValueIfNecessary:dictionary baseUrl:baseUrl]];
                }
            }
        } else {
            [preprocessed setObject:[self preprocessValueIfNecessary:object baseUrl:baseUrl] forKey:key];
        }
    }];
    return preprocessed;
}

@end
