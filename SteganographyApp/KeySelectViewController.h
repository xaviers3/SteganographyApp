//
//  KeySelectViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import <UIKit/UIKit.h>
#import "ButtonLoader.h"

@interface KeySelectViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *secretImageView;
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property(strong, nonatomic) UIImage* secretImage;
@property(strong, nonatomic) UIImage* coverImage;

@property (strong, nonatomic) IBOutlet UITextField *keyTextField;


- (IBAction)encrypt:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *encryptButton;

@end
