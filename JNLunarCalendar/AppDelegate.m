//
//  AppDelegate.m
//  JNLunarCalendar
//
//  Created by NetEase on 2017/1/11.
//  Copyright © 2017年 NetEase. All rights reserved.
//

#import "AppDelegate.h"
#import "JNPopViewController.h"
#import "CalendarIconView.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSPopover *popover;
@property (strong, nonatomic) CalendarIconView *calendarIcon;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // Do any additional setup after loading the view.
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    //[self.statusItem.button setImage:[NSImage imageNamed:@"icon_notice_apply"]];
    self.calendarIcon = [[CalendarIconView alloc] initWithStatusItem:self.statusItem];
    
    self.popover = [[NSPopover alloc] init];
    self.popover.behavior = NSPopoverBehaviorTransient;
    self.popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    self.popover.contentViewController = [[JNPopViewController alloc] initWithNibName:@"JNPopViewController" bundle:nil];
    //self.statusItem.target = self;
    //self.statusItem.button.action = @selector(popoverClick:);
    
    self.calendarIcon.target = self;
    self.calendarIcon.action = @selector(popoverClick:);
    self.calendarIcon.active = FALSE;
    self.calendarIcon.customImage = [NSImage imageNamed:@"calendarIcon"];
    
    __weak typeof(self) weakSelf = self;
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown handler:^(NSEvent * event) {
        if (weakSelf.popover.isShown) {
            [weakSelf.popover close];
            self.calendarIcon.active = FALSE;
        }
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)popoverClick:(NSStatusBarButton *)button {
    if (self.popover.isShown) {
        [self.popover close];
        self.calendarIcon.active = FALSE;
    } else {
        [self.popover showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];
        self.calendarIcon.active = TRUE;
    }
}


@end
