//
//  ShuangZaoTextView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/2/8.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ShuangZaoTextView : NSViewController

@property (nonatomic,weak)IBOutlet NSTextField *mainButton;
@property (nonatomic,weak)IBOutlet NSTextField *yearLabel;
@property (nonatomic,weak)IBOutlet NSTextField *monthLabel;
@property (nonatomic,weak)IBOutlet NSTextField *dayLabel;
@property (nonatomic,weak)IBOutlet NSTextField *hourLabel;
@property (nonatomic,weak)IBOutlet NSButton *selectYearButton;
@property (nonatomic,weak)IBOutlet NSButton *selectMonthButton;
@property (nonatomic,weak)IBOutlet NSButton *selectDayButton;
@property (nonatomic,weak)IBOutlet NSButton *selectHourButton;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel1;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel2;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel3;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel4;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel5;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel6;
@property (nonatomic,weak)IBOutlet NSTextField *daYunLabel7;
@property (nonatomic,weak)IBOutlet NSTextField *textField1;
@property (nonatomic,weak)IBOutlet NSTextField *textField2;

/**
 展示或者隐藏底部textView的按钮
 */
@property (nonatomic,weak)IBOutlet NSButton *bottomNoteTextViewButton;


@end
