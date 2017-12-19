//
//  NSView+Addition.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSView+Addition.h"
#import "objc/runtime.h"

static void * const tagKey = "tagKey";

@implementation NSView (Addition)

-(void)setBackgroundColor:(NSColor *)color{
    self.wantsLayer = YES;
    self.layer.backgroundColor = color.CGColor;
}

-(void)setMyTag:(NSInteger)myTag{
    objc_setAssociatedObject(self, tagKey, @(myTag), OBJC_ASSOCIATION_ASSIGN);
}
    

-(NSInteger)myTag{
    return [(NSNumber*)objc_getAssociatedObject(self, tagKey) integerValue];
}

@end
