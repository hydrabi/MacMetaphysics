//
//  NSLayoutConstraint+NUI.h
//  NUIDemo
//
//  Created by Halin Lee on 1/4/17.
//  Copyright © 2017 Tom Benner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**实现使用定义参数做为约束参数*/
@interface NSLayoutConstraint(NUI)

@property (nonatomic, retain) IBInspectable NSString* nuiDefinition;

@end
