//
//  UIImage+Extension.m
//  MLLCustomer
//
//  Created by sihuan on 15/4/27.
//  Copyright (c) 2015年 Meilele. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize opaque:(BOOL)opaque scale:(CGFloat) scale {
    UIGraphicsBeginImageContextWithOptions(targetSize,opaque,scale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    UIGraphicsBeginImageContext(targetSize);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

- (UIImage *)imageByScalingToSquare:(CGFloat)witdh {
    return [self imageByScalingToSize:CGSizeMake(witdh, witdh)];
}

- (NSData *)asNSData {
    return UIImagePNGRepresentation(self);
}

- (BOOL)saveToDocumentWithName:(NSString *)imageName {
    if (!imageName) {
        return NO;
    }
    NSData *imageData = UIImagePNGRepresentation(self);
    if (!imageData) {
        return NO;
    }
    
    NSString *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fullPath = [documentDir stringByAppendingPathComponent:imageName];
    
    return [imageData writeToFile:fullPath atomically:YES];
}

#pragma mark - 根据图片名返回image对象，如果没有，使用placeHolder
+ (UIImage *)getImageWithName:(NSString *)imageName placeHolder:(NSString *)placeHolderName {
    NSString *documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fullPath = [documentDir stringByAppendingPathComponent:imageName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        return [UIImage imageNamed:placeHolderName];
    }
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)screenShotForView:(UIView *)view {
    if (!view) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (CGSize)fitSizeInView:(UIView *)toView {
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    
    CGSize fitSize = CGSizeZero;
    
    fitSize.width = toView.bounds.size.width;
    CGFloat timesThanScreenWidth = (imageWidth / toView.bounds.size.width);
    fitSize.height = imageHeight / timesThanScreenWidth;
    
    return fitSize;
}


- (CGSize)fitSizeWithMaxHeight{
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGSize fitSize = CGSizeZero;
//    if (self.size.width/screenWidth > self.size.height/(screenHeight-140)) {
        CGFloat height = (self.size.height)/(self.size.width/screenWidth);
    if (height>(screenHeight-140)) {
        height = screenHeight-140;
    }
        fitSize = CGSizeMake(screenWidth, height);
    
//    }else {
//        CGFloat width = self.size.width/(self.size.height/(screenHeight-140));
//        if (width > screenWidth) {
//            width = screenWidth;
//            CGFloat height = (screenHeight-140)/(width/screenWidth);
//            fitSize = CGSizeMake(width, height);
//        }else {
//        
//        CGFloat height1 = self.size.height/(self.size.height/(screenHeight-140));
//        CGFloat width = self.size.width/(self.size.height/(screenHeight-140));
//        
//        CGFloat height;
//        if (self.size.height/(screenHeight-140) > 1) {
//            height = self.size.width/(self.size.height/(screenHeight-140));
//        }else {
//            height = self.size.width*(self.size.height/(screenHeight-140));
//
//        }
//            fitSize = CGSizeMake(screenHeight-140, height);
////        }
//     }
    return fitSize;
    
}

@end
