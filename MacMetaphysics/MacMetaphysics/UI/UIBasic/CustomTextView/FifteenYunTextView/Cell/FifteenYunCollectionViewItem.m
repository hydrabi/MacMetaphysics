//
//  FifteenYunCollectionViewItem.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/16.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "FifteenYunCollectionViewItem.h"
#import "UIConstantParameter.h"
@interface FifteenYunCollectionViewItem ()

@end

@implementation FifteenYunCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.yearLabel.font  = [NSFont systemFontOfSize:titleFontSize_14];
    self.liuNianLabel.font  = [NSFont systemFontOfSize:titleFontSize_20];
    self.xiaoYunLabel.font = [NSFont systemFontOfSize:titleFontSize_14];
}

-(void)resetValueWithIndexPath:(NSIndexPath*)indexPath{
    
}

@end
