//
//  LiuNianTextView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "LiuNianTextView.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
@interface LiuNianTextView ()
@property (nonatomic,strong)NSScrollView *scrollView;
@end

@implementation LiuNianTextView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.view.wantsLayer = YES;
    self.view.layer.borderColor = [NSColor blackColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    
    [self setUpTextView];
}

-(void)setUpTextView{
    NSScrollView *scrollview = [[NSScrollView alloc] init];
    [scrollview setHasVerticalScroller:YES];
    self.scrollView = scrollview;

    NSTextStorage *storage = [[NSTextStorage alloc] init];
    NSLayoutManager *layout = [[NSLayoutManager alloc] init];
    NSTextContainer *container = [NSTextContainer new];
    container.lineBreakMode = NSLineBreakByCharWrapping;
    [layout addTextContainer:container];
    layout.delegate = self;
    [storage addLayoutManager:layout];
    self.myTextView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, screenWidth - leftSideTableViewWidth - leftVerLineWidth*2 - leftVerLineOffset*2 - 14, 1000)
                                        textContainer:container];
    self.myTextView.font = [NSFont systemFontOfSize:titleFontSize_22];
    [self.myTextView setVerticallyResizable:YES];
    [self.myTextView setMaxSize:NSMakeSize(screenWidth - leftSideTableViewWidth - leftVerLineWidth*2 - leftVerLineOffset*2, FLT_MAX)];
    [[self.myTextView textContainer]setContainerSize:NSMakeSize(screenWidth - leftSideTableViewWidth - leftVerLineWidth*2 - leftVerLineOffset*2 , FLT_MAX)];
    [[self.myTextView textContainer]setWidthTracksTextView:YES];
    
    [scrollview setDocumentView:self.myTextView];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.leading.trailing.equalTo(self.view);
    }];
    
}

#pragma mark - NSLayoutManagerDelegate
-(CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(NSRect)rect{
    return 4;
}

@end
