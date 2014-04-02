//
//  UIImage+MLFrostedGlass.m
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "UIImage+MLFrostedGlass.h"
#import "UIImage+MLResized.h"

static CGFloat const kMLFrostedGlassBlurRadius = 2.5f;
static CGFloat const kMLFrostedGlassScale = 1.025f;
static CGFloat const kMLFrostedGlassLighteningAlpha = 0.9f;


@implementation UIImage (MLFrostedGlass)

#pragma mark Image Blur

- (UIImage *)ml_frostedGlassImage
{
	UIImage *scaledDownOriginal = [self ml_imageWithScale:1];
	
	CIImage *ciImage = [CIImage imageWithCGImage:scaledDownOriginal.CGImage];
	ciImage = [self ml_blurredImageFromImage:ciImage withRadius:kMLFrostedGlassBlurRadius];
	ciImage = [self ml_scaledUpImageToCompensateBlurFromImage:ciImage];
	ciImage = [self ml_lighterImageFromImage:ciImage];
	
	return [self ml_renderImage:ciImage withSize:self.size];
}

- (CIImage *)ml_blurredImageFromImage:(CIImage *)image withRadius:(CGFloat)radius
{
	CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
	[filter setValue:image forKey:kCIInputImageKey];
	
	[filter setValue:@(radius) forKey:kCIInputRadiusKey];
	
	return [filter valueForKey:kCIOutputImageKey];
	return image;
}

- (CIImage *)ml_scaledUpImageToCompensateBlurFromImage:(CIImage *)image
{
	CIFilter *filter = [CIFilter filterWithName:@"CIAffineClamp"];
	[filter setValue:image forKey:kCIInputImageKey];
	
	CGAffineTransform transform = CGAffineTransformMakeScale(kMLFrostedGlassScale, kMLFrostedGlassScale);
	[filter setValue:[NSValue valueWithCGAffineTransform:transform] forKey:kCIInputTransformKey];

	return [filter valueForKey:kCIOutputImageKey];
	return image;
}

- (CIImage *)ml_lighterImageFromImage:(CIImage *)image
{
	CIFilter *colorFilter = [CIFilter filterWithName:@"CIConstantColorGenerator"];
	CIColor *color = [CIColor colorWithRed:1.f green:1.f blue:1.f alpha:kMLFrostedGlassLighteningAlpha];
	[colorFilter setValue:color forKey:kCIInputColorKey];
	CIImage *colorImage = [colorFilter valueForKey:kCIOutputImageKey];
	
	CIFilter *composeFilter = [CIFilter filterWithName:@"CISourceAtopCompositing"];
	[composeFilter setValue:image forKey:kCIInputBackgroundImageKey];
	[composeFilter setValue:colorImage forKey:kCIInputImageKey];
	
	return [composeFilter valueForKey:kCIOutputImageKey];
	return image;
}

/*!
 @abstract  
 */
- (UIImage *)ml_renderImage:(CIImage *)image withSize:(CGSize)size
{
	NSDictionary *options = @{
							  kCIContextOutputColorSpace : [NSNull null],
							  kCIContextWorkingColorSpace : [NSNull null],
							  kCIContextUseSoftwareRenderer : @NO,
							  };
	CIContext *context = [CIContext contextWithOptions:options];
	
	CGRect frame = CGRectMake(0.f, 0.f, size.width, size.height);
	CGImageRef cgImage = [context createCGImage:image fromRect:frame];
	
	UIImage *result = [UIImage imageWithCGImage:cgImage scale:self.scale orientation:UIImageOrientationUp];
	CGImageRelease(cgImage);
	
	return result;
}

@end
