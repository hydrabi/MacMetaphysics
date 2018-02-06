//
//  NSPopover+Addition.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/2/6.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSPopover (Addition)

+(NSPopover*)popoverWithRect:(NSRect)rect
       contentViewController:(NSViewController*)contentViewController
                    delegate:(id<NSPopoverDelegate>)delegate
                    rectEdge:(NSRectEdge)rectEdge
                  attachView:(NSView*)attachView;

@end
