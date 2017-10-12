//
//  BasicViewModel.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/4.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BasicViewController;
@interface BasicViewModel : NSObject
@property (nonatomic,weak)BasicViewController *viewController;

/**
 *  初始化
 */
-(void)initialize;
@end
