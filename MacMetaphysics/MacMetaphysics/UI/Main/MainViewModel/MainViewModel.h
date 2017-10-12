//
//  MainViewModel.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BasicViewModel.h"
#import "UIConstantParameter.h"

@interface MainViewModel : BasicViewModel
//左边的菜单页面
@property (nonatomic,strong)NSArray *leftMenuArr;

+(instancetype)sharedInstance;

@end
