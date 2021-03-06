//
//  RootViewController.h
//  EmojiKeyboard
//
//  Created by Shen Shih Yun on 11/7/23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalTableView.h"

@interface EmojiIcon : NSObject
- (id)initWithFilename:(NSString *)aFilename andCode:(NSString*)theCode;
@property (retain, nonatomic) NSString *iconName;
@property (retain, nonatomic) NSString *codeName;

@end

@interface EmojiKeyboardViewController : UIViewController <UITextViewDelegate, HorizontalTableViewDelegate> {
    HorizontalTableView *emojiKeyboard;
}

-(id)initWithFrame:(CGRect)frame;
- (void)addEmojiKeyboard:(NSNotification*)note;
- (NSArray*)initIconsList;
- (void)emojiBtn_pressed:(id)sender;
- (void)keyboardWillShow:(NSNotification*)note;
- (void)keyboardDidShow:(NSNotification*)note;

@property (retain, nonatomic) UITextView            *inputText;
@property (retain, nonatomic) NSArray               *icons;
@property (retain, nonatomic) HorizontalTableView   *emojiKeyboard;

@end
