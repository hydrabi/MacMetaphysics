//
//  BasicEventHandler.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/15.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BasicEventHandler.h"

@implementation BasicEventHandler

-(instancetype)initWithViewModel:(MainViewModel*)viewModel{
    
    self = [super init];
    if(self){
        _viewModel      = viewModel;
        _viewController = (MainViewController*)viewModel.viewController;
        [self initialize];
        [self bindViewModel];
        
    }
    return self;
    
}

-(void)bindViewModel{}

-(void)initialize{}


@end
