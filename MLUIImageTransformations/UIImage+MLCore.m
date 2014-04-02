//
//  UIImage+MLCore.m
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import "UIImage+MLCore.h"

@implementation UIImage (MLCore)

+ (UIImage *)ml_emptyImage
{
	return [UIImage imageWithCIImage:[CIImage emptyImage]];
}

@end
