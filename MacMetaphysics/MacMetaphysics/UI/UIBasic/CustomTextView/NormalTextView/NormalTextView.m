//
//  NormalTextView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "NormalTextView.h"
#import "NSView+Addition.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
@interface NormalTextView ()

@end

@implementation NormalTextView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleLabel.font = [NSFont boldSystemFontOfSize:titleFontSize_20];
    self.textView.font = [NSFont systemFontOfSize:titleFontSize_16];
    
    [self.view setBackgroundColor:[NSColor whiteColor]];
    self.view.layer.borderColor = [NSColor blackColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
}

-(void)reloadData{
    self.titleLabel.text = [[MainViewModel sharedInstance] getSpecificMenuTitleWithType:[MainViewModel sharedInstance].currentBottomSectionMenuType];
}

@end
