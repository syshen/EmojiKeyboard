//
//  RootViewController.h
//  EmojiKeyboard
//
//  Created by Shen Shih Yun on 11/7/23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiIcon : NSObject
- (id)initWithFilename:(NSString *)aFilename andCode:(NSString*)theCode;
@property (retain, nonatomic) NSString *iconName;
@property (retain, nonatomic) NSString *codeName;

@end

@interface EmojiKeyboardViewController : UIViewController <UITextViewDelegate> 

-(id)initWithFrame:(CGRect)frame;
- (void)addEmojiKeys:(NSNotification*)note;
- (NSArray*)initIconsList;

@property (retain, nonatomic) UITextView    *inputText;
@property (retain, nonatomic) NSArray       *icons;

@end
