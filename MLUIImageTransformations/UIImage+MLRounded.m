//
//  UIImage+MLRounded.m
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "UIImage+MLRounded.h"
#import <QuartzCore/QuartzCore.h>

CG_INLINE void MLDrawCircle(CGContextRef context, CGRect rect, CGColorRef fillColor, CGColorRef strokeColor)
{
	CGContextSaveGState(context);
	{
		CGFloat halfWidth = floorf(rect.size.width/2.f);
		CGFloat halfHeight = floorf(rect.size.height/2.f);
		CGContextAddArc(context,
						rect.origin.x + halfWidth, rect.origin.y + halfHeight,
						MIN(halfWidth, halfHeight), 0.f, 2.f * M_PI, YES);
		
		if (fillColor)
		{
			CGContextSetFillColorWithColor(context, fillColor);
			CGContextFillPath(context);
		}
		
		if (strokeColor)
		{
			CGContextSetStrokeColorWithColor(context, strokeColor);
			CGContextStrokePath(context);
		}
	}
	CGContextRestoreGState(context);
}


@implementation UIImage (BODRoundedImage)


#pragma mark Rounded Image

- (UIImage *)ml_roundedImage
{
	return [self ml_roundedImageCropping:UIEdgeInsetsZero
						innerBorderColor:nil
								   width:0.f
						outerBorderColor:nil
								   width:0.f];
}

- (UIImage *)ml_roundedImageCropping:(UIEdgeInsets)cropEdgeInsets
					innerBorderColor:(UIColor *)innerBorderColor
							   width:(CGFloat)innerBorderWidth
					outerBorderColor:(UIColor *)outerBorderColor
							   width:(CGFloat)outerBorderWidth
{
	CGSize cropSize = CGSizeMake(self.size.width - cropEdgeInsets.left - cropEdgeInsets.right,
								 self.size.height - cropEdgeInsets.top - cropEdgeInsets.bottom);
	CGSize roundedImageSize = CGSizeMake(cropSize.width + outerBorderWidth + outerBorderWidth,
										 cropSize.height + outerBorderWidth + outerBorderWidth);
	
	UIGraphicsBeginImageContextWithOptions(roundedImageSize, NO, self.scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect fullRect = {.origin = CGPointZero, .size = roundedImageSize};
	
	CGContextClearRect(context, fullRect);
	
	if (outerBorderColor)
	{
		MLDrawCircle(context, fullRect, outerBorderColor.CGColor, NULL);
	}
	
	UIImage *mask = [self.class ml_roundMaskForSize:roundedImageSize scale:self.scale];
	CGRect pictureRect = CGRectMake(outerBorderWidth - cropEdgeInsets.left,
									outerBorderWidth - cropEdgeInsets.top,
									self.size.width,
									self.size.height);
	CGContextClipToMask(context, pictureRect, mask.CGImage);
	
	[self drawInRect:pictureRect];
	
	if (innerBorderColor)
	{
		CGContextSetLineWidth(context, innerBorderWidth);
		MLDrawCircle(context, pictureRect, NULL, innerBorderColor.CGColor);
	}
	
	UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return roundedImage;
}


#pragma mark Rounded mask images

+ (UIImage *)ml_roundMaskForSize:(CGSize)size scale:(CGFloat)scale
{
	NSCache *cache = [self ml_roundedMaskCache];
	NSString *key = [NSString stringWithFormat:@"%d:%d:%.2f", (int)size.width, (int)size.height, scale];
	UIImage *image = [cache objectForKey:key];
	if (image == nil)
	{
		UIGraphicsBeginImageContextWithOptions(size, NO, scale);
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		CGRect rect = (CGRect) {.origin = CGPointZero, .size = size};
		CGContextClearRect(context, rect);
		
		MLDrawCircle(context, rect, [UIColor blackColor].CGColor, NULL);
		
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		[cache setObject:image forKey:key];
	}
	return image;
}

+ (NSCache *)ml_roundedMaskCache
{
	static NSCache *sCache;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sCache = [[NSCache alloc] init];
	});
	return sCache;
}

@end

