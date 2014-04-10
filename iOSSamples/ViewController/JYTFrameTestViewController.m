//
//  JYTFrameTestViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/10/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTFrameTestViewController.h"

@interface JYTFrameTestViewController ()<UITextFieldDelegate>
{
	UIView* testView;
	
	NSArray* strRegexArray;
	
	int index;
    
    int keyBoardHeight;
}
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextView;
- (IBAction)enterClick:(id)sender;

@end

@implementation JYTFrameTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		
	}
	return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	strRegexArray = @[
					  @"center\\s*=\\s*\\(\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*\\)\\s*",
					  @"frame\\s*=\\s*\\(\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*\\)\\s*",
					  @"scale\\s*=\\s*([-+]?\\d*(\\.\\d*)?)\\s*",
					  @"anchorPoint\\s*=\\s*\\(\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*\\)\\s*",
					  @"bounds\\s*=\\s*\\(\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*\\)\\s*",
					  @"position\\s*=\\s*\\(\\s*([-+]?\\d*(\\.\\d*)?)\\s*,\\s*([-+]?\\d*(\\.\\d*)?)\\s*\\)\\s*"
					  ];
	index = 0;
	
	testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
	testView.backgroundColor = [UIColor blueColor];
	[self.view insertSubview:testView atIndex:0];
    
	UIView* innerView = [[UIView alloc] initWithFrame:CGRectMake(23,23, 4, 4)];
	innerView.backgroundColor = [UIColor redColor];
	[testView addSubview:innerView];
	
	self.outputTextView.font = [UIFont systemFontOfSize:10];
	self.outputTextView.layer.borderWidth = 1;
	self.outputTextView.editable = NO;
	
	self.inputTextView.delegate = self;
	
	
	UITapGestureRecognizer *singleFingerTap =
	[[UITapGestureRecognizer alloc] initWithTarget:self
											action:@selector(handleSingleTap:)];
	[self.view addGestureRecognizer:singleFingerTap];
	
	[self logCurrentState];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleSingleTap:(id) sender
{
    //	[self setEditing:NO];
	[self.inputTextView resignFirstResponder];
	[self.outputTextView resignFirstResponder];
}

-(IBAction)clearOutputText:(id)sender{
    self.outputTextView.text = @"";
}

- (IBAction)enterClick:(id)sender
{
	[self.inputTextView resignFirstResponder];
	
	NSString* inputStr = self.inputTextView.text;
	
	NSError* error = NULL;
	NSRegularExpression* regex;
	for (uint i = 0 ; i<strRegexArray.count; i++) {
		NSString* strRegex = [strRegexArray objectAtIndex:i];
		regex = [NSRegularExpression regularExpressionWithPattern:strRegex options:NSRegularExpressionAllowCommentsAndWhitespace error:&error];
		
		NSTextCheckingResult* firstMatch = [regex firstMatchInString:inputStr options:NSMatchingReportCompletion range:NSMakeRange(0, inputStr.length)];
		if (firstMatch) {
			[self getNumbers:firstMatch sourceString:inputStr];
			switch (i) {
				case 0:
				{
					[self setCenter:firstMatch sourceString:inputStr];
					break;
				}
				case 1:
				{
					[self setFrame:firstMatch sourceString:inputStr];
					break;
				}
				case 2:
				{
					[self setScale:firstMatch sourceString:inputStr];
					break;
				}
				case 3:
				{
					[self setAnchorPoint:firstMatch sourceString:inputStr];
					break;
				}
				case 4:
				{
					[self setBounds:firstMatch sourceString:inputStr];
					break;
				}
				case 5:
				{
					[self setPosition:firstMatch sourceString:inputStr];
					break;
				}
				default:
					break;
			}
		}
        
	}
	
}
-(void) setPosition:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	NSArray* numbers = [self getNumbers:match sourceString:inputStr];
	testView.layer.position = CGPointMake([[numbers objectAtIndex:0] floatValue], [[numbers objectAtIndex:1]floatValue]);
	
	[self addLog:[NSString stringWithFormat:@"set layer.position = ( %@, %@)", [numbers objectAtIndex:0], [numbers objectAtIndex:1]]];
	[self logCurrentState];
}
-(void) setCenter:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	NSArray* numbers = [self getNumbers:match sourceString:inputStr];
	testView.center = CGPointMake([[numbers objectAtIndex:0] floatValue], [[numbers objectAtIndex:1]floatValue]);
	
	[self addLog:[NSString stringWithFormat:@"set center = ( %@, %@)", [numbers objectAtIndex:0], [numbers objectAtIndex:1]]];
	[self logCurrentState];
}
-(void) setBounds:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	
	NSArray* numbers = [self getNumbers:match sourceString:inputStr];
	testView.bounds = CGRectMake([[numbers objectAtIndex:0] floatValue], [[numbers objectAtIndex:1]floatValue], [[numbers objectAtIndex:2]floatValue], [[numbers objectAtIndex:3]floatValue]);
	
	[self addLog:[NSString stringWithFormat:@"set bounds = ( %@, %@, %@, %@)", [numbers objectAtIndex:0], [numbers objectAtIndex:1], [numbers objectAtIndex:2], [numbers objectAtIndex:3]]];
	[self logCurrentState];
}
-(void) setFrame:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	
	NSArray* numbers = [self getNumbers:match sourceString:inputStr];
	testView.frame = CGRectMake([[numbers objectAtIndex:0] floatValue], [[numbers objectAtIndex:1]floatValue], [[numbers objectAtIndex:2]floatValue], [[numbers objectAtIndex:3]floatValue]);
	
	[self addLog:[NSString stringWithFormat:@"set frame = ( %@, %@, %@, %@)", [numbers objectAtIndex:0], [numbers objectAtIndex:1], [numbers objectAtIndex:2], [numbers objectAtIndex:3]]];
	[self logCurrentState];
}
-(void) setScale:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	
	NSArray* numbers = [self getNumbers:match sourceString:inputStr];
	testView.transform = CGAffineTransformIdentity;
	float scale = [[numbers objectAtIndex:0] floatValue];
	testView.transform = CGAffineTransformMakeScale(scale, scale);
	
	[self addLog:[NSString stringWithFormat:@"set scale = %@", [numbers objectAtIndex:0]]];
	[self logCurrentState];
}
-(void) setAnchorPoint:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	
	NSArray* numbers = [self getNumbers:match sourceString:inputStr];
	testView.layer.anchorPoint = CGPointMake([[numbers objectAtIndex:0] floatValue], [[numbers objectAtIndex:1]floatValue]);
	
	[self addLog:[NSString stringWithFormat:@"set layer.anchorPoint = ( %@, %@)", [numbers objectAtIndex:0], [numbers objectAtIndex:1]]];
	[self logCurrentState];
}

-(void) logCurrentState
{
	index ++;
	[self addLog:[NSString stringWithFormat:
				  @"CURRENT STATE(index = %d)\nframe = ( %.3f, %.3f, %.3f, %.3f),\nbounds = ( %.3f, %.3f, %.3f, %.3f), \ncenter = (%.3f, %.3f), \nlayer.anchorPoint = (%.3f, %.3f)\nlayer.position = (%.3f, %.3f)\n",
				  index,
				  testView.frame.origin.x, testView.frame.origin.y, testView.frame.size.width, testView.frame.size.height,
				  testView.bounds.origin.x, testView.bounds.origin.y, testView.bounds.size.width, testView.bounds.size.height,
				  testView.center.x, testView.center.y,
				  testView.layer.anchorPoint.x, testView.layer.anchorPoint.y,
				  testView.layer.position.x, testView.layer.position.y
				  ]];
}
-(NSArray*) getNumbers:(NSTextCheckingResult*)match sourceString:(NSString*) inputStr
{
	NSMutableArray* ret = [[NSMutableArray alloc] initWithCapacity:2];
	for (uint i = 1 ; i < match.numberOfRanges; i+=2) {
		NSRange aRange = [match rangeAtIndex:i];
		if (aRange.length <= inputStr.length) {
			NSString* str = [inputStr substringWithRange:aRange];
			NSNumber* number = [NSNumber numberWithFloat:[str floatValue]];
			[ret addObject:number];
            //			NSLog(@"math( index = %d ). str = %@", i , str);
		}
		else
		{
            //			NSLog(@"out range(index = %d): ( %d, %d )",i, aRange.location, aRange.length);
		}
		
	}
	NSLog(@"%@", ret);
	return ret;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[self moveupWhenEdit];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self enterClick:Nil];
	return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[self movedownWhenEndEdit];
}

- (void) moveupWhenEdit
{
	CGRect frame = self.inputTextView.frame;
    int offset = frame.origin.y + 32  - (self.view.frame.size.height - keyBoardHeight);//英文键盘高度216 中文252
	
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
	
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
	
    [UIView commitAnimations];
}

- (void) movedownWhenEndEdit
{
	NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
	
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
	self.view.frame = CGRectMake(0.0f, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


- (void) addLog:(NSString*) text
{
	NSString* fullText = [NSString stringWithFormat:@"%@\n%@", self.outputTextView.text, text];
	self.outputTextView.text = fullText;
	NSRange range = NSMakeRange(fullText.length - 1, 1);
	[self.outputTextView scrollRangeToVisible:range];
	
	NSLog(@"%@", text);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(![self.inputTextView isExclusiveTouch]){
        [self.inputTextView resignFirstResponder];
        [self movedownWhenEndEdit];
    }
}

- (void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"keyboard changed, keyboard width = %f, height = %f",
          kbSize.width, kbSize.height);
    // 在这里调整UI位置
    
    keyBoardHeight = kbSize.height;
    [self moveupWhenEdit];
}

@end
