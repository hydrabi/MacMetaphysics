//
//  MiddleTableViewCell.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MiddleTableViewCell.h"
#import "UIConstantParameter.h"
#import "NSView+Addition.h"
@interface MiddleTableViewCell ()

@end

@implementation MiddleTableViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shenShaLabel.textColor = [NSColor blackColor];
    self.shenShaLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    [self.shenShaLabel setBackgroundColor:[NSColor clearColor]];
}

@end
