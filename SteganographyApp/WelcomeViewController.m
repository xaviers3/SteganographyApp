//
//  WelcomeViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/5/12.
//
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	/***************************************************************************************
     *  A Tap is a discrete gesture, which sends only one action message when it occurs.   *
     **************************************************************************************/
    
    // Instantiate Tap Gesture Recognizer objects with target and a method to handle specific tap gesture
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleSingleTap:)];
    
    // Add Tap Gesture Recognizers to the imageView
    [self.backgroundImage addGestureRecognizer:singleTap];
    self.welcomeMessage.alpha = 0.0;
    self.continueMessage.alpha = 0.0;
    self.backgroundImage.alpha = 0.0;
    self.inconspiciousImage.alpha = 0.0;
    //self.inspectorImage.alpha = 0.0;
    self.topSecretImage.alpha = 0.0;
    self.inconspiciousImage.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [self fadeInWelcome];
    [self fadeInContinue];
    
    //Grow inspector and inconspicous images
    [self growImages];
    
    //Transition secret image
    [self animateTransition];

}

#pragma mark - Tap Handling Method
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self performSegueWithIdentifier:@"toApp" sender:self];
}

#pragma mark - Animations
-(void)fadeInWelcome{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.50];
    
    self.welcomeMessage.alpha = 1.0;
    self.inspectorImage.alpha = 1.0;
    self.inconspiciousImage.alpha = 1.0;
    
    [UIView commitAnimations];
    
}
-(void)fadeInContinue{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.50];
    [UIView setAnimationDelay:5.0];
    self.continueMessage.alpha = 1.0;
    
    [UIView commitAnimations];
}

-(void)growImages{
    
    //Center: 221,144
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.30];
    self.inspectorImage.transform = CGAffineTransformMakeScale(0.4, 0.4);
    self.inconspiciousImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.inspectorImage.transform = CGAffineTransformMakeRotation(0.2);
    
    [UIView commitAnimations];
}

-(void)animateTransition{
    
    //Transition images
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.30];
    [UIView setAnimationDelay:2.30];
    self.topSecretImage.alpha = 1.0;
    self.inconspiciousImage.alpha = 0.0;
    [UIView commitAnimations];
    
    
}



@end
