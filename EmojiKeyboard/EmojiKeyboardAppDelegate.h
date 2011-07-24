//
//  EmojiKeyboardAppDelegate.h
//  EmojiKeyboard
//
//  Created by Shen Shih Yun on 11/7/23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiKeyboardViewController.h"

@interface EmojiKeyboardAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) EmojiKeyboardViewController *controller;
@end
