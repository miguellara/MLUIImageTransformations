//
//  UIImage+MLResized.m
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "UIImage+MLResized.h"

#import "MLGeometry.h"


@implementation UIImage (MLResized)

#pragma mark Derivating a resized image

- (UIImage *)ml_imageWithScale:(CGFloat)scale
{
	if (self.scale == scale)
	{
		return self;
	}
	else
	{
		return [self ml_imageWithSize:self.size scale:scale];
	}
}

- (UIImage *)ml_imageResizedToFit:(CGSize)size
{
	return [self ml_imageResizedToFit:size scale:self.scale];
}

- (UIImage *)ml_imageResizedToFit:(CGSize)size scale:(CGFloat)scale
{
	BOOL alreadyFitsInSize = self.size.width <= size.width && self.size.height <= size.height;
	BOOL sameScale = self.scale == scale;
	if (alreadyFitsInSize && sameScale)
	{
		return self;
	}
	
	CGSize fittingSize = MLSizeFitInSizeIntegral(size, self.size);
	UIImage *scaled = [self ml_imageWithSize:fittingSize scale:scale];
	
	return scaled;
}

- (UIImage *)ml_imageWithSize:(CGSize)size
{
	return [self ml_imageWithSize:size scale:self.scale];
}

- (UIImage *)ml_imageWithSize:(CGSize)size scale:(CGFloat)scale
{
	if (CGSizeEqualToSize(self.size, size) && self.scale == scale)
	{
		return self;
	}
	
	UIGraphicsBeginImageContextWithOptions(size, YES, scale);
	CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
	
	[self drawInRect:rect];
	
	UIImage *scaled = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return scaled;
}

@end
