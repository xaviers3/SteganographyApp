//
//  EncryptionFunctions.h
//  ImageEncrypt
//
//  Created by Andrew Burkard on 12/3/12.
//  Copyright (c) 2012 Andrew Burkard. All rights reserved.
//

#define kBytesPerPixel 4
#define kBbitsPerComponent 8
#define kHighOrderBits 5
#define kValidID 738275662
#import <Foundation/Foundation.h>

@interface EncryptionFunctions : NSObject

/* Encrypts the secret image inside the public image using an algorithm that depends on the key */
+ (UIImage *)encryptImage:(UIImage *)secretImage inImage:(UIImage *)publicImage withKey:(NSString *)key;

/* Decrypts the image using the key to recover the secret image */
+ (UIImage *)decryptImage:(UIImage *)image withKey:(NSString *)key;

@end
