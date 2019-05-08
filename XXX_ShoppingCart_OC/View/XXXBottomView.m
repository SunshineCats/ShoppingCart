//
//  XXXBottomView.m
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 4/29/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "XXXBottomView.h"

@implementation XXXBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    kWeakSelf
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    _allSelectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_allSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:(UIControlStateNormal)];
    [_allSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:(UIControlStateSelected)];
    [self addSubview:_allSelectButton];
    [_allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(whiteView);
        make.width.height.offset(kCGRectW(30));
    }];
    
    _allSelectLabel = [[UILabel alloc] init];
    _allSelectLabel.font = fontSize(16);
    _allSelectLabel.textColor = kRGBAColor(108, 108, 108, 1);
    [whiteView addSubview:_allSelectLabel];
    [_allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.allSelectButton.mas_right).offset(kCGRectW(5));
        make.centerY.equalTo(weakSelf.allSelectButton);
        make.height.offset(kCGRectH(40));
    }];
    
    _allLabel = [[UILabel alloc] init];
    _allLabel.textColor = [UIColor whiteColor];
    _allLabel.backgroundColor = kRGBAColor(213, 60, 55, 1);
    _allLabel.font = fontSizeBold(18);
    _allLabel.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:_allLabel];
    [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.offset(kCGRectW(150));
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.textAlignment = NSTextAlignmentRight;
    _moneyLabel.font = fontSizeBold(16);
    _moneyLabel.textColor = kRGBAColor(197, 28, 26, 1);
    [whiteView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.allLabel.mas_left).offset(kCGRectX(-5));
        make.top.offset(0);
        make.height.offset(kCGRectH(30));
    }];
    
    _combinedLabel = [[UILabel alloc] init];
    _combinedLabel.font = fontSize(16);
    _combinedLabel.textColor = kRGBAColor(108, 108, 108, 1);
    [whiteView addSubview:_combinedLabel];
    [_combinedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.offset(kCGRectH(30));
        make.right.equalTo(weakSelf.moneyLabel.mas_left).offset(0);
    }];
    
    _noFreightLabel = [[UILabel alloc] init];
    _noFreightLabel.font = fontSize(12);
    _noFreightLabel.textColor = kRGBAColor(108, 108, 108, 1);
    [whiteView addSubview:_noFreightLabel];
    [_noFreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).offset(0);
        make.height.offset(kCGRectH(10));
        make.right.equalTo(weakSelf.allLabel.mas_left).offset(0);
    }];
    
}


@end
