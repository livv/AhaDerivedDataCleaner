//
//  AhaDerivedDataCleaner.m
//  AhaDerivedDataCleaner
//
//  Created by haiwei on 3/10/16.
//  Copyright © 2016 haiwei. All rights reserved.
//

#import "AhaDerivedDataCleaner.h"
#import "MainMenuItem.h"



@interface AhaDerivedDataCleaner()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation AhaDerivedDataCleaner

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    [self addPluginsMenu];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)addPluginsMenu
{
    // Add Plugins menu next to Window menu
    NSMenu *mainMenu = [NSApp mainMenu];
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    
    [pluginsMenuItem.submenu addItem:[NSMenuItem separatorItem]];
    NSMenuItem *mainMenuItem = [[MainMenuItem alloc] init];
    [pluginsMenuItem.submenu addItem:mainMenuItem];
    [pluginsMenuItem.submenu addItem:[NSMenuItem separatorItem]];
    [pluginsMenuItem.submenu addItem:[NSMenuItem separatorItem]];
}


@end
