//
//  HLTwoFooterView.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTwoFooterView : UIView

typedef void (^HLDetailBlock)(HLTwoFooterView *twoFooterView);
@property (nonatomic, copy) HLDetailBlock columnBlock;
@property (nonatomic, copy) HLDetailBlock setBlock;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end
