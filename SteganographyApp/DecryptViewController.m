//
//  DecryptViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import "DecryptViewController.h"
#import "EncryptionFunctions.h"

@interface DecryptViewController ()

@end

@implementation DecryptViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.encryptedImageView.image = self.encryptedImage;
    //produce decrypted Image
    [self generateDecryptedImage];
}

-(void)generateDecryptedImage{
    self.decryptedImage = [EncryptionFunctions decryptImage:self.encryptedImage withKey:self.key];
    if(self.decryptedImage == nil){
        // Create Decryption Alert View
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Was Not Encrypted"
                                                        message:@"Returned Nil"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        // Display the Alert View
        [alert show];

    }else{
        self.decryptedImageView.image = self.decryptedImage;
    }
}

@end
