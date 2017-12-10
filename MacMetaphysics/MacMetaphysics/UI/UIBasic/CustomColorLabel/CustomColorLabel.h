//
//  CustomColorLabel.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/10.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomColorLabel : NSTextField

/**
 只判断其中一个字，这个字段用同样的颜色（默认单个字用对应的颜色）
 */
@property (nonatomic,assign)BOOL useTheSameColor;

@end
