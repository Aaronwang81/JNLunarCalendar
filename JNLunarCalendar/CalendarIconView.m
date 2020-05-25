//
//  CalendarIconView.m
//  JNLunarCalendar
//
//  Created by AaronWang on 2020/5/25.
//  Copyright © 2020 NetEase. All rights reserved.
//

#import "CalendarIconView.h"

@implementation CalendarIconView

{
    NSMutableParagraphStyle *_style;
    NSInteger today;
}

@synthesize customImage = _customImage;
@synthesize statusItem = _statusItem;


- (void)updateDateIcon {
    NSInteger day = [self getDay];
    if(today != day ){
        today = day;
        [self setNeedsDisplay:YES];
    }
}

- (void)drawRect:(NSRect)dirtyRect{
    [self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.active];
    
    NSRect destRect = [self getCenteredRect:self.customImage.size bounds:self.bounds];
    // destRect = NSInsetRect(destRect, 1, 0);

    // Available in OS X v10.6 and later.
    [self.customImage drawInRect:destRect];

    // init string drawing attr
    if(_style == nil) {
        _style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [_style setAlignment:NSCenterTextAlignment];
    }

    // draw day of month
    NSDictionary *attr;
    attr = [NSDictionary  dictionaryWithObjectsAndKeys:
            [NSColor blackColor], NSForegroundColorAttributeName,
            [NSFont fontWithName:@"Helvetica" size:11], NSFontAttributeName,
            _style, NSParagraphStyleAttributeName,
            nil];
    [[NSColor blackColor] set];

    NSString *strDay = [NSString stringWithFormat:@"%02ld", today];
    NSRect calRect = NSMakeRect(2, 6, self.bounds.size.width - 4, self.bounds.size.height - 9);

    [strDay drawInRect:calRect withAttributes:attr];
}

- (NSInteger) getDay{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate: date];
    return [dayComponents day];
}


- (NSRect)getCenteredRect:(NSSize)srcSize bounds:(NSRect)boundRect { 
    CGFloat boundRatio = NSWidth(boundRect) / NSHeight(boundRect);
    CGFloat srcRatio = srcSize.width / srcSize.height;
    
    CGFloat destHeight = 0.0;
    CGFloat destWidth = 0.0;
    if(boundRatio >= srcRatio) {
        // 目标区域比源图像更宽，源图像的两边将留白
        destHeight = NSHeight(boundRect);
        destWidth = destHeight * srcRatio;
    } else {
        // 目标区域比源图像更窄，源图像的上下两边将留白
        destWidth = NSWidth(boundRect);
        destHeight = destWidth / srcRatio;
    }
    
    CGFloat xOffset = (NSWidth(boundRect) - destWidth) / 2.0;
    CGFloat yOffset = (NSHeight(boundRect) - destHeight) / 2.0;
    return NSMakeRect(xOffset, yOffset, NSWidth(boundRect) - xOffset * 2 , NSHeight(boundRect) - yOffset * 2);
}

- (nonnull id)initWithStatusItem:(nonnull NSStatusItem *)statusItem { 
    self = [super initWithFrame:NSZeroRect];
    if (self != nil) {
        statusItem.view = self;
    }
    
    today = [self getDay];
    
    //每小时更新一次图标,
    [NSTimer scheduledTimerWithTimeInterval: 5
      target:self
    selector:@selector(updateDateIcon)
    userInfo:nil
     repeats:YES];
    
    return self;
}


@end
