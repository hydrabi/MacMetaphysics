//
//  LiuNianTextView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "LiuNianTextView.h"
#import "UIConstantParameter.h"

@interface LiuNianTextView ()

@end

@implementation LiuNianTextView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.view.wantsLayer = YES;
    self.view.layer.borderColor = [NSColor blackColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    
    self.textView.font = [NSFont systemFontOfSize:titleFontSize_20];
}

@end
