#include "REPhoneDialer.h"

%hook SBLockScreenView 

-(void)didMoveToWindow {

	CGRect screenRect = [[UIScreen mainScreen] bounds];

    CGFloat screenWidth = screenRect.size.width;

    CGFloat screenHeight = screenRect.size.height;

	scroll = MSHookIvar <SBLockScreenScrollView *>(self, "_foregroundScrollView");

	scroll.pagingEnabled = YES;

	buttonsView *testView = [[buttonsView alloc] initWithFrame:CGRectMake(screenWidth + 320 , 20, screenWidth, screenHeight)];

	[testView addButtonsToView];
	
    [scroll addSubview: testView];	

	%orig;

}

-(void)_slideToUnlockFailureGestureRecognizerChanged {

	//to prevent the lockscreen from scrolling back to the first page

}

%end

%hook SBLockScreenScrollView 

-(BOOL)gestureRecognizer:(id)recognizer shouldReceiveTouch:(id)touch {

	CGRect screenRect = [[UIScreen mainScreen] bounds];

    CGFloat screenWidth = screenRect.size.width;

	self.contentSize = CGSizeMake(screenWidth * 3, self.frame.size.height); //change the width of the scroll view, 3 can be changed to whatever number pages you want

	return %orig();
	
}

%end
