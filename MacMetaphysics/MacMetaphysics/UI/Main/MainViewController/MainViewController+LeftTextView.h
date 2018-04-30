//
//  MainViewController+LeftTextView.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/4/30.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (LeftTextView)

-(void)leftTextViewConfig;


//清空所有textView
-(void)clearAllTextView;

//读取记录
-(void)readLeftTextRecordData;

//将textView的数据保存入字典
-(void)saveLeftTextRecordData;

@end
