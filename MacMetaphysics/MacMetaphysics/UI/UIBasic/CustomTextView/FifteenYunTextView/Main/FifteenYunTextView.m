//
//  FifteenYunTextView.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/16.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "FifteenYunTextView.h"
#import "FifteenYunDataSource.h"
#import "FifteenYunTitleView.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "NSView+Addition.h"
@interface FifteenYunTextView ()
@property (nonatomic,strong)NSMutableArray *textFieldsArr;
@property (nonatomic,strong)FifteenYunDataSource *dataSource;
@property (nonatomic,strong)FifteenYunTitleView *titleView;
@property (nonatomic,strong)NSCollectionView *collectionView;
@end

@implementation FifteenYunTextView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
    [self makeConstraints];
    [self bindViewModel];
}

-(void)UIConfig{
    [self.view setBackgroundColor:[NSColor whiteColor]];
    self.view.layer.borderColor = [NSColor blackColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    
    self.collectionView = [[NSCollectionView alloc] initWithFrame:NSZeroRect];
    [self.view addSubview:self.collectionView];
    self.dataSource = [[FifteenYunDataSource alloc] initWithCollectionView:self.collectionView];
    
    self.titleView = [FifteenYunTitleView instanceBasicNibView];
    [self.view addSubview:self.titleView];
    
    self.textFieldsArr = @[].mutableCopy;
    for(NSInteger i = 0;i<daYunSubTableViewCount;i++){
        NSTextField *textField = [[NSTextField alloc] initWithFrame:CGRectZero];
        textField.drawsBackground = NO;
        textField.bordered = NO;
        textField.tag = i;
        textField.font = [NSFont systemFontOfSize:titleFontSize_14];
        [self.view addSubview:textField];
        [self.textFieldsArr addObject:textField];
    }
}

-(void)makeConstraints{
    @weakify(self)
    [self.titleView makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.top).offset(0);
        make.leading.equalTo(self.view.leading).offset(0);
        make.trailing.equalTo(self.view.trailing).offset(0);
        make.height.equalTo(daYunSubTitleViewHeight);
    }];
    
    [self.collectionView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.view.leading).offset(0);
        make.top.equalTo(self.titleView.bottom);
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.width.equalTo(daYunSubTableViewWidth);
    }];
    
    NSTextField *lastTextField = nil;
    for(NSInteger i = 0;i<self.textFieldsArr.count;i++){
        NSTextField *textField = self.textFieldsArr[i];
        
        [textField makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.leading.equalTo(self.collectionView.trailing).offset(offset_16);
            if(lastTextField){
                if(i == 5){
                    make.top.equalTo(lastTextField.bottom).offset(daYunSubTableViewMiddleOffset);
                }
                else{
                    make.top.equalTo(lastTextField.bottom).offset(0);
                }
            }
            else{
                make.top.equalTo(self.view.top).offset(daYunSubTitleViewHeight);
            }
            make.trailing.equalTo(self.view.trailing).offset(@(-offset_16));
            make.height.equalTo(daYunSubTableCellHeight);
        }];
        
        lastTextField = textField;
    }
}

-(void)bindViewModel{
    MainViewModel *mainViewModel = [MainViewModel sharedInstance];
    @weakify(self)
    [RACObserve(mainViewModel.fifteenYunData, fifteenYunSelectedNumber)
     subscribeNext:^(id _){
         @strongify(self)
         [self reloadData];
     }];
}

-(void)reloadData{
    [self.titleView reloadData];
    [self.collectionView reloadData];
}

@end
