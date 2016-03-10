//
//  DMMDerivedDataHandler.h
//  AhaDerivedData
//
//  Created by haiwei on 3/10/16.
//  Copyright © 2016 haiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface DMMDerivedDataHandler : NSObject

+ (void)clearDerivedDataForProject:(NSString*)projectName;
+ (void)clearAllDerivedData;
+ (void)clearModuleCache;

@end
