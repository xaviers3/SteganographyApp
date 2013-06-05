//
//  EncryptViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import <UIKit/UIKit.h>
#import "EncryptionFunctions.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ButtonLoader.h"

@interface EncryptViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UIImageView *encryptedImageView;
@property(strong, nonatomic) UIImage* secretImage;
@property(strong, nonatomic) UIImage* coverImage;
@property(strong, nonatomic) UIImage* encryptedImage;
@property(strong, nonatomic) NSString* key;
- (IBAction)saveImage:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@end
