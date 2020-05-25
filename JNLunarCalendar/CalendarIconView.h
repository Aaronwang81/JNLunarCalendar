//
//  CalendarIconView.h
//  JNLunarCalendar
//
//  Created by AaronWang on 2020/5/25.
//  Copyright © 2020 NetEase. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarIconView : NSButton

@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *customImage;

@property BOOL active;


- (id)initWithStatusItem:(NSStatusItem *)statusItem;

- (NSRect) getCenteredRect:(NSSize)srcSize bounds:(NSRect)boundRect;
- (void) updateDateIcon;

@end

NS_ASSUME_NONNULL_END
