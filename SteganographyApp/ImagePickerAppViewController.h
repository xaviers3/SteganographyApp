//
//  ImagePickerAppViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/5/12.
//
//

#import <UIKit/UIKit.h>
#import "ButtonLoader.h"

@interface ImagePickerAppViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

//
@property(nonatomic, retain) UIImagePickerController *imgPicker;

@property (strong, nonatomic) IBOutlet UIImageView *selectedImageView;

@property (strong, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (strong, nonatomic) UIButton* continueButton;

@property(strong, nonatomic) UIImage* secretImage;
@property(strong, nonatomic) UIImage* coverImage;
@property(strong, nonatomic) UIImage* encryptedImage;

- (IBAction)selectPhoto:(id)sender;

@end
