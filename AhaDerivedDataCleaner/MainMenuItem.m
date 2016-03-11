//
//  MainMenuItem.m
//  AhaDerivedData
//
//  Created by haiwei on 3/10/16.
//  Copyright © 2016 haiwei. All rights reserved.
//

#import "MainMenuItem.h"
#import "DMMDerivedDataHandler.h"

#define RandomRange(min, max) (arc4random_uniform(max - min) + min)

#define PluginVersion ([[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])



typedef NS_ENUM(NSUInteger, MenuItemType) {
    kMenuItemTypeCleanForProject = 1,
    kMenuItemTypeCleanAll,
    kMenuItemTypeCleanModuleCache,
};


@interface NSObject (IDEWorkspaceWindowController)
+ (id)workspaceWindowControllers;
@end


@interface MainMenuItem ()


@end


@implementation MainMenuItem

- (instancetype)init
{
    if (self = [super init]) {
        
        self.title = [NSString stringWithFormat:@"Aha DerivedData Cleaner (v%@)", PluginVersion];
        
        NSMenu *configMenu = [[NSMenu alloc] init];
        configMenu.autoenablesItems = NSOffState;
        self.submenu = configMenu;

        
        NSMenuItem *cleanPrjMenuItem = [self menuItemWithTitle:@"Clean DerivedData for this project" type:kMenuItemTypeCleanForProject];
        [cleanPrjMenuItem setKeyEquivalent:@"h"];
        [cleanPrjMenuItem setKeyEquivalentModifierMask:NSShiftKeyMask | NSCommandKeyMask];
        [configMenu addItem:cleanPrjMenuItem];
        
        NSMenuItem *cleanAllMenuItem = [self menuItemWithTitle:@"Clean All Derived Data" type:kMenuItemTypeCleanAll];
        [configMenu addItem:cleanAllMenuItem];
        
        NSMenuItem *cleanCacheMenuItem = [self menuItemWithTitle:@"Clean Module Cache" type:kMenuItemTypeCleanModuleCache];
        [configMenu addItem:cleanCacheMenuItem];
        
    }
    
    return self;
}

- (NSMenuItem *)menuItemWithTitle:(NSString *)title type:(MenuItemType)type
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = title;
    menuItem.tag = type;
    menuItem.target = self;
    menuItem.action = @selector(clickMenuItem:);
    return menuItem;
}


- (void)clickMenuItem:(NSMenuItem *)menuItem
{
    MenuItemType type = menuItem.tag;
    
    switch (type) {
            
        case kMenuItemTypeCleanForProject:
            [self cleanDerivedDataForKeyWindow];
            break;
            
        case kMenuItemTypeCleanAll:
            [self cleanAllDerivedData];
            break;
            
        case kMenuItemTypeCleanModuleCache:
            [self cleanModuleCache];
            break;
    }
    
}


#pragma mark -

- (void)cleanDerivedDataForKeyWindow
{
    NSArray* workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") workspaceWindowControllers];
    
    for (id controller in workspaceWindowControllers) {
        if ([[controller valueForKey:@"window"] isKeyWindow]) {
            id workspace = [controller valueForKey:@"_workspace"];
            [DMMDerivedDataHandler clearDerivedDataForProject:[workspace valueForKey:@"name"]];
            return;
        }
    }
}

- (void)cleanAllDerivedData
{
    [DMMDerivedDataHandler clearAllDerivedData];
}

- (void)cleanModuleCache
{
    [DMMDerivedDataHandler clearModuleCache];
}

@end
