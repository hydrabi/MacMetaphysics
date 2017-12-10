//
//  NSView+Addition.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSView+Addition.h"

@implementation NSView (Addition)

-(void)setBackgroundColor:(NSColor *)color{
    self.wantsLayer = YES;
    self.layer.backgroundColor = color.CGColor;
}

@end
