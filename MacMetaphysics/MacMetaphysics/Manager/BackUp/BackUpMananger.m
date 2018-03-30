//
//  BackUpMananger.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/29.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BackUpMananger.h"
#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "FNHUD.h"
#import "MainViewModel.h"
#import "MainViewController.h"
@implementation BackUpMananger

-(instancetype)init{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
}

-(void)showSavePath{
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    openDlg.delegate = self;
    [openDlg setCanChooseDirectories:YES];
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanCreateDirectories:YES];
    [openDlg setMessage:@"选择备份路径"];
    [openDlg setCanCreateDirectories:YES];
    
    AppDelegate *delegate = (AppDelegate*)[NSApplication sharedApplication].delegate;
    [openDlg beginSheetModalForWindow:delegate.mainWindowViewController.window
                    completionHandler:^(NSModalResponse response){
                        if(response == NSModalResponseOK){
                            
                            NSString *storeName = [MagicalRecord defaultStoreName];
                            NSURL *sourceUrl = [NSPersistentStore MR_urlForStoreName:storeName];
                            //取目录路径
                            NSURL *sourceDirectory = [sourceUrl URLByDeletingLastPathComponent];
                            
                            NSURL *destUrl = [openDlg URL];
                            
                            NSFileManager *fileManager = [NSFileManager defaultManager];
                            NSError *error = nil;
                            
                            //该目录有三个文件 遍历保存
                            NSArray *dirArr = [fileManager contentsOfDirectoryAtPath:[[sourceDirectory path] stringByAppendingString:@""] error:nil];
                            for (NSString *path in dirArr){
                                NSString *fullPath = [[sourceDirectory path] stringByAppendingPathComponent:path];
                                NSString *destPath = [[destUrl path] stringByAppendingPathComponent:path];
                                BOOL result = [fileManager copyItemAtPath:fullPath toPath:destPath error:&error];
                                if(result){
                                    [FNHUD showSuccess:@"备份成功" inView:[MainViewModel sharedInstance].viewController.view];
                                }
                                else{
                                    [FNHUD showError:@"备份失败" inView:[MainViewModel sharedInstance].viewController.view];
                                }
                            }
                        }
                    }];
}

@end
