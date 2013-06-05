//
//  ButtonLoader.m
//  SteganographyApp
//
//  Created by CS4704 on 12/9/12.
//
//

#import "ButtonLoader.h"

@implementation ButtonLoader


+(void) loadButtonImage:(UIButton*) button{
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
    UIImage *stretchableButtonImageNormal = [buttonImageNormal
											 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [button setBackgroundImage:stretchableButtonImageNormal
                      forState:UIControlStateNormal];
	
    UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed
											  stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[button setBackgroundImage:stretchableButtonImagePressed
                      forState:UIControlStateHighlighted];
    
}
@end
