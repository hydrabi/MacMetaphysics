//
//  SingleBottomXiaoYunView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SingleBottomXiaoYunView.h"
#import "UIConstantParameter.h"

static CGFloat alphaNumber = 0.3;

@implementation SingleBottomXiaoYunView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)awakeFromNib{
    
    self.yearLabel.font = [NSFont systemFontOfSize:titleFontSize_20];
    self.liuNianLabel.font = [NSFont systemFontOfSize:titleFontSize_24];
    
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
        self.liuNianLabel.wantsLayer = YES;
        self.liuNianLabel.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    }
    else{
        
        self.liuNianLabel.wantsLayer = YES;
        self.liuNianLabel.layer.backgroundColor = [NSColor clearColor].CGColor;

    }
}

@end
