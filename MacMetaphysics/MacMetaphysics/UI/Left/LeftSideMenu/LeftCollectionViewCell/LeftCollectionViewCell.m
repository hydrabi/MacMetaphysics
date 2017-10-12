//
//  LeftCollectionViewCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "LeftCollectionViewCell.h"
#import "UIConstantParameter.h"

@interface LeftCollectionViewCell ()

@end

@implementation LeftCollectionViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.textColor = [NSColor blackColor];
    self.titleLabel.font = [NSFont systemFontOfSize:titleFontSize_24];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor clearColor].CGColor;

}

@end
