//
//  NSPopover+Addition.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/2/6.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "NSPopover+Addition.h"

@implementation NSPopover (Addition)

+(NSPopover*)popoverWithRect:(NSRect)rect
       contentViewController:(NSViewController*)contentViewController
                    delegate:(id<NSPopoverDelegate>)delegate
                    rectEdge:(NSRectEdge)rectEdge
                  attachView:(NSView*)attachView{
    NSPopover *popover = [[NSPopover alloc] init];
    popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    popover.contentViewController = contentViewController;
    popover.behavior = NSPopoverBehaviorTransient;
    [popover showRelativeToRect:rect ofView:attachView preferredEdge:rectEdge];
    return popover;
}

@end
