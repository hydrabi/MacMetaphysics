//
//  ScreenShotManager.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/19.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "ScreenShotManager.h"
#import "DSCapture.h"
#import "AppDelegate.h"
static NSString * kFilePath = @"kFilePath";

@implementation ScreenShotManager

-(instancetype)init{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

-(void)initialize{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEndCapture:) name:kNotifyCaptureEnd object:nil];
}

- (void)displayCaptureData: (DSCaptureData *) sender{
    NSData *data = [sender dataAtIndex:0];
    NSImage *image = [sender imageAtIndex:0];
    NSUInteger count = [sender count];
    
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    openDlg.delegate = self;
    openDlg.canChooseDirectories = YES;
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanCreateDirectories:YES];
    [openDlg setAllowsMultipleSelection:YES];
    [openDlg setResolvesAliases:YES];
    
    NSURL *url = openDlg.directoryURL;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *delegate = (AppDelegate*)[NSApplication sharedApplication].delegate;
    [openDlg beginSheetModalForWindow:delegate.mainWindowViewController.window
                    completionHandler:^(NSModalResponse response){
                        if(response == NSModalResponseOK) {
                            NSArray *fileURLs = [openDlg URLs];
//                            NSImage *image = [[NSImage alloc] initWithContentsOfURL:
//                                              [fileURLs objectAtIndex:0]];
//                            NSLog(@"%@", [fileURLs objectAtIndex:0]);
//                            // Deal with the image.
//                            [image release];
                            
                            NSURL *url = fileURLs[0];
                            
                            //保存文件路径
                            [defaults setObject:url.path forKey:kFilePath];
                            
                            [defaults synchronize];
                        }

                    }];
    
//    [openDlg beginWithCompletionHandler:^(NSModalResponse response){
//        if(response == NSFileHandlingPanelOKButton){
//            
//            NSArray *fileURLs = [openDlg URLs];
//            
//            for(NSURL *url in fileURLs) {
//                
//                NSError *error;
//                
//                //保存文件路径
//                [defaults setObject:url.path forKey:kFilePath];
//                
//                [defaults synchronize];
//                
//                
//            }
//        }
//    }];
}

-(void)start{
    [[[DSCapture sharedCapture] full] captureWithTarget:self selector:@selector(displayCaptureData:) useCG:NO];
}

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url{
    return YES;
}

@end
