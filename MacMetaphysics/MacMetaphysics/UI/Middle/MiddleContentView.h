//
//  MiddleContentView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UIConstantParameter.h"

@interface MiddleContentView : NSViewController

/**
 设置乾坤按钮的类型

 @param type 乾坤的枚举类型
 */
-(void)setGenderButtonWithType:(UniverseType)type;

@end
