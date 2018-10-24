//
//  CommonViewController.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLOneFooterView.h"
#import "HLTwoFooterView.h"
#import "HLImageHeaderView.h"
#import "HLTitleHeaderView.h"
@interface CommonViewController : UIViewController
@property (nonatomic, strong) HLOneFooterView *oneFooterView;
@property (nonatomic, strong) HLTwoFooterView *twoFooterView;
@property (nonatomic, strong) HLImageHeaderView *imageHeaderView;
@property (nonatomic, strong) HLTitleHeaderView *titleHeaderView;

-(void)initWithFooterView:(BOOL)i andHeaderView:(BOOL)j andText:(NSString *)text;

@end
