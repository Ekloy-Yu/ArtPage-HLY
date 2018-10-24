//
//  HLInputView.h
//  ArtPage
//
//  Created by 何龙 on 2018/10/15.
//  Copyright © 2018 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomKeyboardDelegate

-(void) keyboardItemDidClicked:(NSString *) item;

@end

@interface HLInputView : UIView<UITextFieldDelegate>

@property(nonatomic, weak) id<CustomKeyboardDelegate> delegate;
typedef void(^InputBlock) (HLInputView *view);
@property (nonatomic, copy) InputBlock deleteBlock;
@property (nonatomic, copy) InputBlock doneBlock;

@end
