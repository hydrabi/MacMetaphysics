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

}

- (void)displayCaptureData: (DSCaptureData *) sender{
    
    
    NSSavePanel *openDlg = [NSSavePanel savePanel];
    openDlg.delegate = self;
//    openDlg.canChooseDirectories = YES;
//    [openDlg setCanChooseFiles:YES];
    [openDlg setCanCreateDirectories:YES];
//    [openDlg setAllowsMultipleSelection:YES];
//    [openDlg setResolvesAliases:YES];
//    [openDlg setNameFieldStringValue:@"Untitle.onecodego"];
    [openDlg setMessage:@"设置图片名称"];
    [openDlg setAllowsOtherFileTypes:YES];
    [openDlg setAllowedFileTypes:@[@"png"]];
    [openDlg setExtensionHidden:YES];
    [openDlg setCanCreateDirectories:YES];
    
    AppDelegate *delegate = (AppDelegate*)[NSApplication sharedApplication].delegate;
    [openDlg beginSheetModalForWindow:delegate.mainWindowViewController.window
                    completionHandler:^(NSModalResponse response){
                        if(response == NSModalResponseOK) {
                            
                            NSURL *url = [openDlg URL];
                            NSData *data = [sender dataAtIndex:0];
                            NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:data];
                            NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.9] forKey:NSImageCompressionFactor];
                            data = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
                            NSString *realPath = [[url path] stringByAppendingString:@""];
                            [data writeToFile:realPath atomically:YES];
                        }

                    }];
    
}

-(void)start{
    [[[DSCapture sharedCapture] full] captureWithTarget:self selector:@selector(displayCaptureData:) useCG:NO];
}

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url{
    return YES;
}

@end
