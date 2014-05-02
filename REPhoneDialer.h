#include <SpringBoard-iOS7/SBLockScreenView.h>
#include <SpringBoard-iOS7/SBLockScreenScrollView.h>
#include <SpringBoard-iOS7/SBLockScreenViewController.h>
#include <TelephonyUI-iOS7/TPDialerKeypadProtocol.h>
#include <TelephonyUI-iOS7/TPNumberPadLightStyleButton.h>
#import <objc/runtime.h>

extern void CTCallDial(NSString * number);

static SBLockScreenScrollView *scroll = nil;

@protocol TPDialerKeypadDelegate <NSObject>
@optional
-(void)phonePad:(id)arg1 appendString:(id)arg2;
-(void)phonePad:(id)arg1 keyDown:(BOOL)arg2;
-(void)phonePad:(id)arg1 keyUp:(BOOL)arg2;
-(void)phonePadWillBeginSounds:(id)arg1;
-(void)phonePadDidEndSounds:(id)arg1;
-(void)phonePad:(id)arg1 replaceLastDigitWithString:(id)arg2;
-(void)phonePadDeleteLastDigit:(id)arg1;
-(void)phonePad:(id)arg1 dialerCharacterButtonWasHeld:(unsigned)arg2;
@end

@interface _UIBackdropView : UIView

-(id)initWithFrame:(CGRect)frame autosizesToFitSuperview:(BOOL)size settings:(id)settings;

-(void)setBlurRadius:(CGFloat)arg1;
@end

@interface _UIBackdropViewSettingsAdaptiveLight

-(id)settingsForStyle:(int)style;

@end

@protocol TPSimpleNumberPadDelegate
- (void)simpleNumberPadDeletePressed:(id)arg1;
- (void)simpleNumberPad:(id)arg1 buttonPressedWithCharacter:(id)arg2;
@end


@interface TPNumberPad : UIControl
@property(nonatomic) float buttonBackgroundAlpha;
@property(retain) NSArray *buttons; // @dynamic buttons;
- (void)_setBackgroundAlphaOnButton:(id)arg1 alpha:(CGFloat)arg2;
- (void)_addButton:(id)arg1;
- (id)initWithButtons:(id)arg1;

@end

@interface TPDialerNumberPad : TPNumberPad
+(id)dialerNumberPadNumericCharacters;
+(id)dialerNumberPadFullCharacters;
@property id <TPDialerKeypadDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) BOOL playsSounds;

@end

@interface TPBottomBar : UIView
@end

@interface TPButton : UIButton
+(id)answerButtonImage;
-(void)setButtonColor:(int)arg1;
@end

@interface TPBottomSingleButtonBar : TPBottomBar
-(id)button;
-(void)setButton:(id)arg1 andStyle:(BOOL)arg2;
-(id)initForEndCallWithFrame:(struct CGRect)arg1;
@end

@interface TPLCDBar : UIView

@end

@interface TPLCDView : TPLCDBar
-(void)setText:(id)text;
-(id)text;
@end

@interface buttonsView : UIView <UITextViewDelegate, TPDialerKeypadDelegate> {
    
	TPLCDView *lcdView;
	TPDialerNumberPad *pad;
	NSString *number;
    
}
-(NSArray *)buttons;

-(void)addButtonsToView;

-(void)call:(UIButton *)button;

@end

