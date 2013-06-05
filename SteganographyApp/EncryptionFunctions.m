//
//  EncryptionFunctions.m
//  ImageEncrypt
//
//  Created by Andrew Burkard on 12/3/12.
//  Copyright (c) 2012 Andrew Burkard. All rights reserved.
//

#import "EncryptionFunctions.h"
#import <stdlib.h>

@implementation EncryptionFunctions

+ (UIImage *)encryptImage:(UIImage *)secretImage inImage:(UIImage *)publicImage withKey:(NSString *)key
{
    publicImage = [self adjustSizeOf:publicImage withRespectTo:secretImage];
    CGImageRef publicImageRef = [publicImage CGImage];
    CGImageRef secretImageRef = [secretImage CGImage];
    unsigned char *publicImagePixels = getRawPixelValues(publicImageRef);
    unsigned char *secretImagePixels = getRawPixelValues(secretImageRef);
    NSInteger width = CGImageGetWidth(publicImageRef);
    NSInteger height = CGImageGetHeight(publicImageRef);
    NSInteger numPixels = width*height;
    
    NSUInteger seed = [self integerFromKey:key];
    unsigned int* permutation = generateRandomPermutation(seed, numPixels*kBytesPerPixel);
    
    hidePixels(secretImagePixels, publicImagePixels, width, height, permutation);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(publicImagePixels, width, height, 8, width*kBytesPerPixel, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGImageRef encryptedImageRef = CGBitmapContextCreateImage(context);
    UIImage* encryptedImage = [UIImage imageWithCGImage:encryptedImageRef];
    
    CGContextRelease(context);
    free(publicImagePixels);
    free(secretImagePixels);
    
    return encryptedImage;
    
}

+ (UIImage *)decryptImage:(UIImage *)image withKey:(NSString *)key
{
    CGImageRef imageRef = [image CGImage];
    unsigned char *imagePixels = getRawPixelValues(imageRef);
    
    NSInteger width = CGImageGetWidth(imageRef);
    NSInteger height = CGImageGetHeight(imageRef);
    NSInteger numPixels = width*height;
    
    NSUInteger seed = [self integerFromKey:key];
    unsigned int* invPermutation = generateInversePermutation(seed, numPixels*kBytesPerPixel);
    
    unsigned char *secretImagePixels = unHidePixels(imagePixels, numPixels, invPermutation);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(secretImagePixels, width, height, 8, width*kBytesPerPixel, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGImageRef secretImageRef = CGBitmapContextCreateImage(context);
    UIImage* secretImage = [UIImage imageWithCGImage:secretImageRef];
    
    CGContextRelease(context);
    free(secretImagePixels);
    free(imagePixels);
    free(invPermutation);
    
    return secretImage;
    
}


#pragma mark - Pixel alteration
/* Converts an image into an array of pixel values */
unsigned char* getRawPixelValues(CGImageRef imageRef)
{
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerRow = width *kBytesPerPixel;
    
    unsigned char *rawData = (unsigned char*) calloc(height * width * kBytesPerPixel, sizeof(unsigned char));
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, kBbitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGContextRelease(context);
    
    return rawData;
}

/* Hides the values of secret pixels in public pixels */
void hidePixels(unsigned char* secretPixels, unsigned char* publicPixels, unsigned int width, unsigned int height, unsigned int* permutation)
{
    unsigned int numPixels = width*height;
    
    for(int byteIndex = 0; byteIndex < numPixels*kBytesPerPixel; byteIndex++)
    {
        unsigned char publicPixelValue = publicPixels[byteIndex];
        unsigned char secretPixelValue = secretPixels[permutation[byteIndex]];
        
        publicPixelValue = (publicPixelValue & 0xf8) | (secretPixelValue >> kHighOrderBits);
        
        publicPixels[byteIndex] = publicPixelValue;
    }
}

/* Extracts the hidden image pixels from the encrypted pixels */
unsigned char* unHidePixels(unsigned char* encryptedPixels, unsigned int numPixels, unsigned int* permutation)
{
    unsigned char* secretPixels = (unsigned char*) calloc(numPixels * kBytesPerPixel, sizeof(unsigned char));
    
    for(int byteIndex = 0 ; byteIndex < numPixels*kBytesPerPixel; byteIndex++)
    {
        unsigned char encryptedPixelValue = encryptedPixels[permutation[byteIndex]];
        unsigned char secretPixelValue = encryptedPixelValue << kHighOrderBits;
        
        secretPixels[byteIndex] = secretPixelValue;
    }
    
    return secretPixels;
}

#pragma mark - Key permutation generation
/* Generates a pseudo-random deterministic permutation of the integers {0,...,n-1} */
unsigned int* generateRandomPermutation(int seed, unsigned int n)
{
    srandom(seed);
    
    unsigned int* permutation = malloc(sizeof(unsigned int)*n);
    
    for (unsigned int i=0;i<n;i++)
        permutation[i]=i;
    
    return permutation;
    
    for (unsigned int i=0;i<n;i++)
    {
        unsigned int j = random() % n;
        unsigned int temp = permutation[i];
        permutation[i]=permutation[j];
        permutation[j]=temp;
        
    }
    
    return permutation;
}

/* Generates a permutation based on the seed, then reverses it */
unsigned int* generateInversePermutation(int seed, unsigned int n)
{
    srandom(seed);
    
    unsigned int* permutation = generateRandomPermutation(seed, n);
    return permutation;
    unsigned int* inverse = malloc(sizeof(unsigned int)*n);
    
    for (unsigned int i=0;i<n;i++)
        inverse[permutation[i]] = i;
    
    free(permutation);
    
    return inverse;
}

/* Converts the key to an integer value */
+(NSUInteger)integerFromKey:(NSString *)key
{
    return 1;
    return [key hash];
}


#pragma mark - Image resizing
/* Returns a resized image */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    //UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/* Makes the public image large enough to hold the secret image, and it's dimension values */
+ (UIImage *)adjustSizeOf:(UIImage *)publicImage withRespectTo:(UIImage *)secretImage
{
    CGImageRef secretImageRef = [secretImage CGImage];
    double width = (double)CGImageGetWidth(secretImageRef);
    double height = (double)CGImageGetHeight(secretImageRef);
    
    return [self imageWithImage:publicImage scaledToSize:CGSizeMake(width, height)];
}

@end
