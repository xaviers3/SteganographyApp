//
//  WelcomeViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/5/12.
//
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController<UIImagePickerControllerDelegate>

@property(strong, nonatomic)  IBOutlet  UILabel * welcomeMessage;
@property (strong, nonatomic) IBOutlet UIImageView *inspectorImage;
@property (strong, nonatomic) IBOutlet UIImageView *inconspiciousImage;
@property (strong, nonatomic) IBOutlet UIImageView *topSecretImage;
@property (strong, nonatomic) IBOutlet UILabel *continueMessage;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;


@end
