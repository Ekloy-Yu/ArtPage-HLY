//
//  HLWebHeaderView.h
//  ArtPage
//
//  Created by 何龙 on 2018/10/11.
//  Copyright © 2018 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLWebHeaderView : UIView

@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

typedef void(^WebBlock) (HLWebHeaderView *view);
@property (nonatomic, strong) WebBlock backBlock;
@property (nonatomic, strong) WebBlock refreshBlock;

-(id)initWithFrame:(CGRect)frame
             title:(NSString *)text;
@end
