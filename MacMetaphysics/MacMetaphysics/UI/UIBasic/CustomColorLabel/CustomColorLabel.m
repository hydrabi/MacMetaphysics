//
//  CustomColorLabel.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/10.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "CustomColorLabel.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "NSColor+Addition.h"
@implementation CustomColorLabel

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if(self){
        
    }
    return self;
}

-(void)bindViewModel{
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:notificationKey_changeColor
                                                           object:nil]
     subscribeNext:^(id _){
         @strongify(self)
         [self drawColorWithText:self.text];
     }];
}

-(void)setStringValue:(NSString *)stringValue{
    [super setStringValue:stringValue];
    [self drawColorWithText:stringValue];
}

-(void)drawColorWithText:(NSString*)text{
    if([[MainViewModel sharedInstance].currentSelectTopSectionMenuTypeArr containsObject:@(LeftSideMenuTypeYanSe)]
       && text.length>0){
        if(self.useTheSameColor){
            self.textColor = [NSColor getColorWithString:self.text];
        }
        else{
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
            for(NSInteger i = 0;i<text.length;i++){
                NSString *subString = [text substringWithRange:NSMakeRange(i, 1)];
                [attributeString addAttribute:NSForegroundColorAttributeName
                                        value:[NSColor getColorWithString:subString]
                                        range:NSMakeRange(i, 1)];
                
            }
            self.attributedStringValue = attributeString;
        }
    }
    else{
        self.textColor = [NSColor blackColor];
    }
}

@end
