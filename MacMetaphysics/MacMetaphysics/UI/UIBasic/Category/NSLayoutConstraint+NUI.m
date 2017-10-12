//
//  NSLayoutConstraint+NUI.m
//  NUIDemo
//
//  Created by Halin Lee on 1/4/17.
//  Copyright © 2017 Tom Benner. All rights reserved.
//

#import "NSLayoutConstraint+NUI.h"
#import "objc/runtime.h"
#import "UIConstantParm.h"
static void * const kNUIAssociatedNuiDefinition = "nuiDefinition";
@implementation NSLayoutConstraint(NUI)


- (void)setNuiDefinition:(NSString *)nuiDefinition{
    
    objc_setAssociatedObject(self, kNUIAssociatedNuiDefinition, nuiDefinition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if(nuiDefinition){
        self.constant = [[UIConstantParm shareInstance] getValueWithKey:nuiDefinition].floatValue;
    }
    
}

- (NSString *)nuiDefinition{
    return objc_getAssociatedObject(self, kNUIAssociatedNuiDefinition);
}

@end
