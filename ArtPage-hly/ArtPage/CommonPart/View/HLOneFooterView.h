//
//  HLOneFooterView.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLOneFooterView : UIView
typedef void (^BackBlock)(HLOneFooterView *oneFooterView);
@property (nonatomic, copy) BackBlock Block;
@property (nonatomic, strong) UIButton *footerBtn;
@end
