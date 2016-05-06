//
//  UIImage+Extension.m
//  uu
//
//  Created by xww on 16/2/26.
//  Copyright © 2016年 梁晋杰. All rights reserved.
//

#import "UIImage+Extension.h"


@implementation UIImage (Extension)

- (UIImage *)imageAeroWithBlurRadius:(CGFloat)blurRadius {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithDouble:blurRadius] forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
@end
