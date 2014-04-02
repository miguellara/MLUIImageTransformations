//
//  UIImage+MLResized.h
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MLResized)

/*!
 @abstract Creates an image resized to match the given scale, respecting its aspect ratio.
 @note The same image instance is returned if no resizing is required.
 */
- (UIImage *)ml_imageWithScale:(CGFloat)scale;

/*!
 @abstract Creates an image resized to fit the given size, scaling up if necessary respecting the original aspect ratio.
 The scale of this image instance is assumed.
 @note The same image instance is returned if no resizing is required.
 */
- (UIImage *)ml_imageResizedToFit:(CGSize)size;

/*!
 @abstract Creates an image resized to fit the given size, scaling up if necessary respecting the original aspect ratio.
 @note The same image instance is returned if no resizing is required.
 */
- (UIImage *)ml_imageResizedToFit:(CGSize)size scale:(CGFloat)scale;

/*!
 @abstract Creates an image resized to fill the given size, scaling without respecting the original aspect ratio.
 The scale of this image instance is assumed.
 @note The same image instance is returned if no resizing is required.
 */
- (UIImage *)ml_imageWithSize:(CGSize)size;

/*!
 @abstract Creates an image resized to fill the given size, scaling without respecting the original aspect ratio.
 @note The same image instance is returned if no resizing is required.
 */
- (UIImage *)ml_imageWithSize:(CGSize)size scale:(CGFloat)scale;

@end
