//
//  SaveViewController.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SaveViewController.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
    [self setUpTableViewDataSource];
}

-(void)bindViewModel{
    @weakify(self)
    [[self.keySearchButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
        @strongify(self)
         
    }];
}

-(void)setUpTableViewDataSource{
    self.tableViewDataSource = [[SaveTableViewDataSource alloc] initWithViewModel:self.viewModel
                                                                   viewController:self];
}

@end
