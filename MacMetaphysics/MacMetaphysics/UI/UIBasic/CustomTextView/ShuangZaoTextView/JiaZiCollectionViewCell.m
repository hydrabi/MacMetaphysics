//
//  JiaZiCollectionViewCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/1/14.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "JiaZiCollectionViewCell.h"
#import "UIConstantParameter.h"
@interface JiaZiCollectionViewCell ()

@end

@implementation JiaZiCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.font = [NSFont systemFontOfSize:titleFontSize_24];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
