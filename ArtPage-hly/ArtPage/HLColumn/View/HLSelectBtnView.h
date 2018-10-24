//
//  HLSelectBtnView.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLSelectBtnView : UIView
@property (nonatomic, strong) UIButton *btn0;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *btn5;
typedef void(^HLBtnBlock) (HLSelectBtnView *hlSelectBtnView);
@property (nonatomic, strong) HLBtnBlock block0;
@property (nonatomic, strong) HLBtnBlock block1;
@property (nonatomic, strong) HLBtnBlock block2;
@property (nonatomic, strong) HLBtnBlock block3;
@property (nonatomic, strong) HLBtnBlock block4;
@property (nonatomic, strong) HLBtnBlock block5;
-(id)initWithFrame:(CGRect)frame andImageNameArr:(NSArray *)arr;
@end
