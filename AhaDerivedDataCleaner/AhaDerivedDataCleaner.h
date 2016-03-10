//
//  AhaDerivedDataCleaner.h
//  AhaDerivedDataCleaner
//
//  Created by haiwei on 3/10/16.
//  Copyright © 2016 haiwei. All rights reserved.
//

#import <AppKit/AppKit.h>

@class AhaDerivedDataCleaner;

static AhaDerivedDataCleaner *sharedPlugin;

@interface AhaDerivedDataCleaner : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end