//
//  UIConstantParm.h
//  Metaphysics
//
//  Created by Hydra on 2017/1/31.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIConstantParm : NSObject

+(instancetype)shareInstance;
-(NSNumber*)getValueWithKey:(NSString*)key;
@end
