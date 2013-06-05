//
//  DecryptKeyViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import <UIKit/UIKit.h>
#import "ButtonLoader.h"

@interface DecryptKeyViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *encryptedImageView;
@property (strong, nonatomic) UIImage* encryptedImage;

@property (strong, nonatomic) IBOutlet UITextField *keyTextField;
- (IBAction)decrypt:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *decryptButton;

@end
