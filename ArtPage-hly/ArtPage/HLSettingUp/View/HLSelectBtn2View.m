//
//  HLSelectBtn2View.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLSelectBtn2View.h"

@implementation HLSelectBtn2View
-(id)initWithFrame:(CGRect)frame andImageNameArr:(NSArray *)arr
{
    if(self = [super initWithFrame:frame])
    {
        for(int i = 0; i < 6; i++)
        {
                _commonBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                _commonBtn.tag = i;
                [_commonBtn setImage:[UIImage imageNamed:arr[i]] forState:(UIControlStateNormal)];
                [_commonBtn addTarget:self action:@selector(commonBtnSelected:) forControlEvents:(UIControlEventTouchUpInside)];
                [self addSubview:_commonBtn];
                [_commonBtn makeConstraints:^(MASConstraintMaker *make) {
                    if(i < 3)
                    {
                        make.left.equalTo(39 + i * ((SCREENWIDTH - 77 - 6) / 3 + 3));
                        make.bottom.equalTo(self.bottom).offset(-87);
                    }
                    else
                    {
                        make.left.equalTo(39 + (i - 3) * ((SCREENWIDTH - 77 - 6) / 3 + 3));
                        make.bottom.equalTo(self.bottom).offset(0);
                    }
                    make.size.equalTo(CGSizeMake((SCREENWIDTH - 78 - 6) / 3, 80));
                }];
            
        }
    }
    return self;
}
-(void)commonBtnSelected:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            if(_block0)
            {
                _block0(self);
            }
            break;
        case 1:
            if(_block1)
            {
                _block1(self);
            }
            break;
        case 2:
            if(_block2)
            {
                _block2(self);
            }
            break;
        case 3:
            if(_block3)
            {
                _block3(self);
            }
            break;
        case 4:
            if(_block4)
            {
                _block4(self);
            }
            break;
        case 5:
            if(_block5)
            {
                _block5(self);
            }
            break;
            
        default:
            break;
    }
}

@end
