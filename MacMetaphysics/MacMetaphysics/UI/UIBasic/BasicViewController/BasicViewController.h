//
//  BasicViewController.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/4.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BasicViewModel;
@interface BasicViewController : NSViewController
@property (nonatomic,strong)BasicViewModel *viewModel;


-(instancetype)initWithViewModel:(BasicViewModel*)viewModel;
@end
