//
//  ChooseViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/5/12.
//
//

#import <UIKit/UIKit.h>

@interface ChooseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *saved;
- (IBAction)encryptionSelected:(id)sender;
- (IBAction)decryptionSelected:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *encryptButton;
@property (strong, nonatomic) IBOutlet UIButton *decryptButton;



@end
