//
//  DecryptKeyViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import "DecryptKeyViewController.h"
#import "DecryptViewController.h"

@interface DecryptKeyViewController ()

@end

@implementation DecryptKeyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.encryptedImageView.image = self.encryptedImage;
    [ButtonLoader loadButtonImage:self.decryptButton];
}


- (IBAction)decrypt:(id)sender {
    [self performSegueWithIdentifier:@"toDecrypt" sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];  // Deactivate the text field
    return YES;
}

#pragma mark - Preparing for Segue

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"toDecrypt"]) {
        DecryptViewController *decryptViewController = [segue destinationViewController];
        
        //Pass encrypted image and key
        [decryptViewController setEncryptedImage:self.encryptedImage];
        [decryptViewController  setKey:self.keyTextField.text];
    }
}


@end
