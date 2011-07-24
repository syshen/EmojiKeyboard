//
//  RootViewController.m
//  EmojiKeyboard
//
//  Created by Shen Shih Yun on 11/7/23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EmojiKeyboardViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation EmojiIcon
@synthesize iconName, codeName;
- (id)initWithFilename:(NSString *)aFilename andCode:(NSString*)theCode {
    self.iconName = aFilename;
    self.codeName = theCode;
    return self;
}
- (void) dealloc {
    [iconName release];
    [codeName release];
    [super dealloc];
}
@end


@implementation EmojiKeyboardViewController
@synthesize inputText;
@synthesize icons;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.frame = frame;
        
        UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, 100)];
        txt.delegate = self;

        txt.backgroundColor = [UIColor yellowColor];
        self.inputText = txt;
        [self.view addSubview:self.inputText];
        [txt release];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	// add observer for the respective notifications (depending on the os version)
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardDidShow:) 
													 name:UIKeyboardDidShowNotification 
												   object:nil];		
	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
	}
    
    self.icons = [self initIconsList];
    [super viewDidLoad];
}

- (NSArray*)initIconsList {
    NSMutableArray  *tmp = [[NSMutableArray alloc] init];
    
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"01.gif" andCode:@":-))"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"02.gif" andCode:@":-)"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"03.gif" andCode:@":-D"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"04.gif" andCode:@"(LOL)"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"05.gif" andCode:@":-P"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"06.gif" andCode:@"(woot)"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"07.gif" andCode:@";-)"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"08.gif" andCode:@":-o"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"09.gif" andCode:@"X-C"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"10.gif" andCode:@":-C"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"11.gif" andCode:@":'-C"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"12.gif" andCode:@":-&"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"13.gif" andCode:@"(angry)"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"14.gif" andCode:@"(annoyed)"] autorelease]];
    [tmp addObject:[[[EmojiIcon alloc] initWithFilename:@"15.gif" andCode:@"(K)"] autorelease]];

    return [tmp autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.inputText = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [inputText release];
    [icons release];
    [super dealloc];
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification*)note {
    // if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
		[self addEmojiKeys:note];
	}
}

- (void)keyboardDidShow:(NSNotification*)note {
    // if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[self addEmojiKeys:note];
    }
}

- (void)addEmojiKeys:(NSNotification*)note {
    CGRect _keyboardEndFrame;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&_keyboardEndFrame];
        
    
    UIView *emojiKeyboard = [[[UIView alloc] init] autorelease];
    emojiKeyboard.backgroundColor = [UIColor lightGrayColor];
    emojiKeyboard.frame = CGRectMake(0, -50, _keyboardEndFrame.size.width, 50);

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = emojiKeyboard.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor grayColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(0, 0);
    [emojiKeyboard.layer insertSublayer:gradient atIndex:0];
    
    int idx = 0;
    for (EmojiIcon *e in icons) {
        UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(idx * 50, 5, 40, 40)];
        [btn setImage:[UIImage imageNamed:e.iconName] forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:self action:@selector(emojiBtn_pressed:) forControlEvents:UIControlEventTouchUpInside];
        idx ++;
        [emojiKeyboard addSubview:btn];
        [btn release];
    }
        
    UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i = 0; i < [keyboardWindow.subviews count]; i++)
	{
		//Get a reference of the current view 
		keyboard = [keyboardWindow.subviews objectAtIndex:i];
		
		//Check to see if the description of the view we have referenced is "UIKeyboard" if so then we found
		//the keyboard view that we were looking for
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:emojiKeyboard];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:emojiKeyboard];
		}
	}
    //[emojiKeyboard release];
}

- (void)emojiBtn_pressed:(id)sender {
    UIButton *btn = (UIButton*)sender;
    EmojiIcon *e = [icons objectAtIndex:btn.tag];
    inputText.text = [[NSString alloc] initWithFormat:@"%@%@", inputText.text, e.codeName];
}


@end
