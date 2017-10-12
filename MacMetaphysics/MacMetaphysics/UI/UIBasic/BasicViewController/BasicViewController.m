//
//  BasicViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/4.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BasicViewController.h"
#import "BasicViewModel.h"
@interface BasicViewController ()

@end

@implementation BasicViewController

-(instancetype)initWithViewModel:(BasicViewModel*)viewModel{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if(self) {
        self.viewModel = viewModel;
        self.viewModel.viewController = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
