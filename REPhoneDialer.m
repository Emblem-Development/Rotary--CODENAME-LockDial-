#import "REPhoneDialer.h"

@implementation buttonsView

-(void)call:(UIButton*)button{ //do call button things
    
	CTCallDial(lcdView.text);
    
}

-(void)simpleNumberPadDeletePressed:(id)deleteButton { //here we are going to figure out the delete button
    
	if ([lcdView.text length] > 0) {
        
		lcdView.text = [lcdView.text substringToIndex:[lcdView.text length]-1];
        
	}
    
}

-(void)phonePad:(id)arg1 appendString:(id)text { // add the text to the TPLCDView , this is a DELEGATE method
    
	NSLog(@"TEXT %@",text);
    
	if (lcdView.text == nil) {
        
		[lcdView setText:text];
        
	} else {
        
		[lcdView setText:[NSString stringWithFormat:@"%@%@", lcdView.text, text]];
        
	}
    
}

-(NSArray *)buttons {
    
    //set up the button array for the numberpad
    
	TPNumberPadLightStyleButton *pound = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:10];
    
	TPNumberPadLightStyleButton *test = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:11];
    
	TPNumberPadLightStyleButton *one = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:0];
    
	TPNumberPadLightStyleButton *two = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:1];
    
	TPNumberPadLightStyleButton *three = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:2];
    
	TPNumberPadLightStyleButton *four = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:3];
    
	TPNumberPadLightStyleButton *five = [[NSClassFromString(@"TPNumberPadLightStyleButton")alloc] initForCharacter:4];
    
	TPNumberPadLightStyleButton *six = [[NSClassFromString(@"TPNumberPadLightStyleButton")alloc] initForCharacter:5];
    
	TPNumberPadLightStyleButton *seven = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:6];
    
	TPNumberPadLightStyleButton *eight = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:7];
    
	TPNumberPadLightStyleButton *nine = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:8];
    
	TPNumberPadLightStyleButton *zero = [[NSClassFromString(@"TPNumberPadLightStyleButton") alloc] initForCharacter:9];
    
    
	NSArray *buttonArray = [NSArray arrayWithObjects:one,two,three,four,five,six,seven,eight,nine,zero,pound,test,nil];
    
	return buttonArray;
    
}

-(void)addButtonsToView {
    
	CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat screenWidth = screenRect.size.width;
    
    CGFloat screenHeight = screenRect.size.height;
    
	TPBottomSingleButtonBar *callButton = [[NSClassFromString(@"TPBottomSingleButtonBar") alloc] initForEndCallWithFrame: CGRectMake(0,screenHeight-100,screenWidth,screenHeight)];
    
	pad = [[NSClassFromString(@"TPDialerNumberPad") alloc] initWithButtons:[self buttons]]; //init with our custom button array
    
	[pad setFrame: CGRectMake(18,screenHeight-470,screenWidth,screenHeight)];
    
	pad.buttonBackgroundAlpha = 0.0;
    
	pad.delegate = self;
    
	pad.playsSounds = YES;
    
	lcdView = [[NSClassFromString(@"TPLCDView") alloc] initWithFrame: CGRectMake(0,0,screenWidth,90)];
    
	[lcdView layoutSubviews];
    
    //call button properties
    
	[callButton.button setImage:nil forState:0];
    
	[callButton.button setImage:nil forState:1];
    
	[callButton.button setTitle:@"Call" forState:0];
    
	[callButton.button setTitle:@"Call" forState:1];
    
	[callButton.button setButtonColor:0];
    
	[callButton.button addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    
    
	Class UIBackDropView = NSClassFromString(@"_UIBackdropView");
    
    if (UIBackDropView) //if the device can generate a UIBackDropView
        
    {
        id settings = nil;
        
        Class _UIBackdropViewSettingsAdaptiveLight = NSClassFromString(@"_UIBackdropViewSettingsAdaptiveLight");
        
        if (_UIBackdropViewSettingsAdaptiveLight)
            
            
        {
            
            settings = [_UIBackdropViewSettingsAdaptiveLight settingsForStyle:2060]; // 2060 is the system control center background view style
        }
        
        
        UIView *backView = (UIView *) [[UIBackDropView alloc] initWithFrame:CGRectMake(0,0,0,0) autosizesToFitSuperview:YES settings:settings];
        
        //backView.tag = 1337;
        
        [self addSubview:backView];
        
        
        
    }
    
    //add the views here. THIS ORDER MATTERS!
    
	[self addSubview: pad];
    
	[self addSubview: lcdView];
    
	[self addSubview:callButton];
    
    
}


@end
