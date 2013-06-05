//
//  KeySelectViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import "KeySelectViewController.h"
#import "EncryptViewController.h"

@interface KeySelectViewController ()

@end

@implementation KeySelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.secretImageView.image = self.secretImage;
    self.coverImageView.image = self.coverImage;
    [ButtonLoader loadButtonImage:self.encryptButton];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];  // Deactivate the text field
    return YES;
}
- (IBAction)encrypt:(id)sender {
    [self performSegueWithIdentifier:@"toEncrypt" sender:self];
}

#pragma mark - Preparing for Segue

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"toEncrypt"]) {
        EncryptViewController *encryptViewController = [segue destinationViewController];
        
        //Pass secret image, cover image, and key
        [encryptViewController setSecretImage:self.secretImage];
        [encryptViewController setCoverImage:self.coverImage];
        [encryptViewController  setKey:self.keyTextField.text];
    }
}
@end
