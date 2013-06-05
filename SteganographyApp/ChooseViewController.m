//
//  ChooseViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/5/12.
//
//

#import "ChooseViewController.h"
#import "ButtonLoader.h"

@interface ChooseViewController ()

@end

@implementation ChooseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ButtonLoader loadButtonImage:self.encryptButton];
    [ButtonLoader loadButtonImage:self.decryptButton];
    self.saved.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)encryptionSelected:(id)sender {
    [self performSegueWithIdentifier:@"toEncrypt" sender:self];
}

- (IBAction)decryptionSelected:(id)sender {
    [self performSegueWithIdentifier:@"toDecrypt" sender:self];
}


@end
