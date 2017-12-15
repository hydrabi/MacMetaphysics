//
//  BottomTableViewCell.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomTableViewCell.h"
#import "NSTextField+Addition.h"
#import "UIConstantParameter.h"

static CGFloat alphaNumber = 0.3;

@interface BottomTableViewCell ()

@end

@implementation BottomTableViewCell

-(void)viewDidLoad{
    self.yearLabel.font = [NSFont systemFontOfSize:titleFontSize_18];
    self.liuNianLabel.font = [NSFont systemFontOfSize:titleFontSize_26];
}

-(void)hideContent{
    self.yearLabel.alphaValue = alphaNumber;
    self.liuNianLabel.alphaValue = alphaNumber;
    
}

-(void)showContent{
    self.yearLabel.alphaValue = 1;
    self.liuNianLabel.alphaValue = 1;
    
}

-(void)selectCell:(BOOL)select{
    if(select){
        self.liuNianLabel.backgroundColor = [NSColor grayColor];
    }
    else{
        self.liuNianLabel.backgroundColor = [NSColor clearColor];
    }
}

@end
