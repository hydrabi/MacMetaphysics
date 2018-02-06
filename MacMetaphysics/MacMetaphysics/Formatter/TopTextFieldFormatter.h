//
//  TopTextFieldFormatter.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/1/1.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIConstantParameter.h"
@interface TopTextFieldFormatter : NSNumberFormatter
//判断topContentView输入限制的类型
@property (nonatomic,assign)TopViewFormatterType formatterType;

-(instancetype)initWithType:(TopViewFormatterType)type;

@end
