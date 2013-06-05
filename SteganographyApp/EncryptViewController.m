//
//  EncryptViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import "EncryptViewController.h"
#import "ChooseViewController.h"

@interface EncryptViewController ()

@end

@implementation EncryptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     self.coverImageView.image = self.coverImage;
    //produce Encrypted Image
    [self generateEncryptedImage];
    [ButtonLoader loadButtonImage:self.saveButton];

}

- (IBAction)saveImage:(id)sender {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageDataToSavedPhotosAlbum: UIImagePNGRepresentation(self.encryptedImage) metadata:nil completionBlock:nil];
    ChooseViewController* chooseViewController =  (ChooseViewController*)[self.navigationController.viewControllers objectAtIndex:0];
    chooseViewController.saved.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)generateEncryptedImage{
    self.encryptedImage = [EncryptionFunctions encryptImage:self.secretImage inImage:self.coverImage withKey:self.key];
    self.encryptedImageView.image = self.encryptedImage;
}
@end
