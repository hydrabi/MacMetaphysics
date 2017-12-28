//
//  SeparatorTableViewCell.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/27.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SeparatorTableViewCell.h"
#import "NSView+Addition.h"
@interface SeparatorTableViewCell ()

@end

@implementation SeparatorTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    if(!self.tailLineView){
        self.tailLineView = [[NSBox alloc] init];
        [self.tailLineView setBoxType:NSBoxSeparator];
        [self.tailLineView setBackgroundColor:[NSColor blackColor]];
        [self.view addSubview:self.tailLineView];
        [self.tailLineView makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.view.top).offset(0);
            make.bottom.equalTo(self.view.bottom);
            make.trailing.equalTo(self.view.trailing).offset(0);
            make.width.equalTo(@1);
        }];
    }
    
    if(!self.floorLineView){
        self.floorLineView = [[NSBox alloc] init];
        [self.floorLineView setBoxType:NSBoxSeparator];
        [self.floorLineView setBackgroundColor:[NSColor blackColor]];
        [self.view addSubview:self.floorLineView];
        [self.floorLineView makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.view.bottom).offset(0);
            make.leading.equalTo(self.view.leading).offset(0);
            make.trailing.equalTo(self.view.trailing).offset(0);
            make.height.equalTo(@1);
        }];
    }
}

-(void)showFloorLine{
    self.floorLineView.hidden = NO;
}

-(void)hideFloorLine{
    self.floorLineView.hidden = YES;
}

-(void)showTailLine{
    self.tailLineView.hidden = NO;
}

-(void)hideTailLine{
    self.tailLineView.hidden = YES;
}

@end
