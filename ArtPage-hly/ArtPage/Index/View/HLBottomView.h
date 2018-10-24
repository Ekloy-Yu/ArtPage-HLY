//
//  HLBottomView.h
//  ArtPage
//
//  Created by 何龙 on 2018/10/8.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLBottomView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIButton *saveBtn;

typedef void (^btnBlock)(HLBottomView *view);

@property (nonatomic, copy) btnBlock block;

@property (nonatomic, copy) btnBlock saveBlock;

-(id)initWithFrame:(CGRect)frame
        titleLabel:(NSString *)titleText
      contentLabel:(NSString *)contentText
             width:(CGFloat)width;
@end
