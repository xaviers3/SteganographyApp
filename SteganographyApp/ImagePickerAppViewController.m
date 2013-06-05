//
//  ImagePickerAppViewController.m
//  SteganographyApp
//
//  Created by CS4704 on 12/5/12.
//
//

#import "ImagePickerAppViewController.h"
#import "KeySelectViewController.h"
#import "DecryptKeyViewController.h"
#import "ChooseViewController.h"

@interface ImagePickerAppViewController ()
@property(strong, nonatomic) UIActionSheet* actionSheet;
@property NSInteger selectedOption;

@property NSString* firstImageTitle;
@property NSString* secondImageTitle;
@property NSString* decryptImageTitle;
@end

@implementation ImagePickerAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _firstImageTitle = @"Select Image To Hide";
    _secondImageTitle = @"Select 'Cover' Image";
    _decryptImageTitle = @"Select Image To Extract Secret";
    
	self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = NO;
    self.imgPicker.delegate = self;
    
    [ButtonLoader loadButtonImage:self.selectPhotoButton];
}

-(void) viewDidAppear:(BOOL)animated{
    ChooseViewController* chooseViewController =  (ChooseViewController*)[self.navigationController.viewControllers objectAtIndex:0];
    chooseViewController.saved.hidden = YES;
}

-(void) loadContinueButton{
    
    CGPoint newLocation = CGPointMake(20+self.selectPhotoButton.frame.size.width/2, 363);
    self.selectPhotoButton.center = newLocation;
    
    //self.selectPhotoButton.alpha = 0.0;
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aButton addTarget:self
               action:@selector(continueOn)
     forControlEvents:UIControlEventTouchUpInside];
    [aButton setTitle:@"Continue" forState:UIControlStateNormal];
    aButton.frame = CGRectMake(self.view.frame.size.width-135, 341, 115.0, 44.0);
    self.continueButton = aButton;
    [ButtonLoader loadButtonImage:self.continueButton];
    
    
    [self.view addSubview:self.continueButton];
}



- (IBAction)selectPhoto:(id)sender {
    UIActionSheet *selectUploadType = [[UIActionSheet alloc] initWithTitle:@"Select Media Type" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Select Image From Library", @"Take Picture", nil];
    
    //[self imagePickerController:nil didFinishPickingMediaWithInfo:nil];

    [selectUploadType setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    [selectUploadType setTag:1];
    [selectUploadType showInView:self.view];
}




#pragma mark - delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"run");
    self.selectedImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if([self.navigationItem.title isEqualToString:_firstImageTitle]){
        self.secretImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
                            
    if([self.navigationItem.title isEqualToString:_secondImageTitle]){
        self.coverImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if([self.navigationItem.title isEqualToString:_decryptImageTitle]){
        self.encryptedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
                            
    self.selectedImageView.contentMode = UIViewContentModeCenter;
    [self loadContinueButton];
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


-(void)continueOn{
    if([self.navigationItem.title isEqualToString:_firstImageTitle]){
        [self performSegueWithIdentifier:@"toSecondImageSelect" sender:self];
    }
    if([self.navigationItem.title isEqualToString:_secondImageTitle]){
        [self performSegueWithIdentifier:@"toKeyEntry" sender:self];
    }
    
    if([self.navigationItem.title isEqualToString:_decryptImageTitle]){
        [self performSegueWithIdentifier:@"toDecryptionKeyEntry" sender:self];
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //self.imgPicker.delegate = self;
    switch (actionSheet.tag)
    {
            // Select Upload Type actionsheet
        case 1:
            switch (buttonIndex) {
                    // Select Picture/Video
                case 0:
                    self.imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    [self presentViewController:self.imgPicker animated:YES completion:nil];
                    break;
                    // Take Picture
                case 1:
                    self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:self.imgPicker animated:YES completion:nil];
            }
    }
}


#pragma mark - Preparing for Segue

// This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
// You never call this method. It is invoked by the system.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"toSecondImageSelect"]) {
        // Obtain the object reference of the destination view controller
        ImagePickerAppViewController *secondImagePickerAppViewController = [segue destinationViewController];
        
        //Set secret image
        [secondImagePickerAppViewController setSecretImage:self.secretImage];

    }
    if([segueIdentifier isEqualToString:@"toKeyEntry"]){
        // Obtain the object reference of the destination view controller
        KeySelectViewController *keySelectViewController = [segue destinationViewController];
        
        //Pass secret and cover images
        [keySelectViewController setSecretImage:self.secretImage];
        [keySelectViewController setCoverImage:self.coverImage];
    }
    
    if([segueIdentifier isEqualToString:@"toDecryptionKeyEntry"]){
        DecryptKeyViewController* decryptKeyViewController = [segue destinationViewController];
        [decryptKeyViewController setEncryptedImage:self.encryptedImage];
    }
    
}


@end
