//
//  NSObject_Extension.m
//  AhaDerivedDataCleaner
//
//  Created by haiwei on 3/10/16.
//  Copyright © 2016 haiwei. All rights reserved.
//


#import "NSObject_Extension.h"
#import "AhaDerivedDataCleaner.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[AhaDerivedDataCleaner alloc] initWithBundle:plugin];
        });
    }
}
@end
