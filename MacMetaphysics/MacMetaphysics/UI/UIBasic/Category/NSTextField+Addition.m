//
//  UILabel+Addition.m
//  Metaphysics
//
//  Created by Hydra on 2017/2/7.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSTextField+Addition.h"
#import "objc/runtime.h"
static void * const originalSizeKey = "originalSizeKey";

@implementation NSTextField (Addition)


-(void)setOriginalSize:(CGFloat)originalSize{
    objc_setAssociatedObject(self, originalSizeKey,@(originalSize), OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)originalSize{
    return [(NSNumber*)objc_getAssociatedObject(self, originalSizeKey) floatValue];
}

-(void)setBoldFont{
    self.font = [NSFont boldSystemFontOfSize:self.font.pointSize];
}

-(void)setOriginalFont{
    self.font = [NSFont systemFontOfSize:self.font.pointSize];
}

@end
