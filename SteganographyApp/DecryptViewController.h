//
//  DecryptViewController.h
//  SteganographyApp
//
//  Created by CS4704 on 12/7/12.
//
//

#import <UIKit/UIKit.h>

@interface DecryptViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *encryptedImageView;
@property (strong, nonatomic) IBOutlet UIImageView *decryptedImageView;
@property(strong, nonatomic) UIImage* encryptedImage;
@property(strong, nonatomic) UIImage* decryptedImage;
@property(strong, nonatomic) NSString* key;
@end
