//
//  MLGeometry.h
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#ifndef MLUIImageTransformations_MLGeometry_h
#define MLUIImageTransformations_MLGeometry_h

/*!
 @abstract Calculates the rect that fills inside the bounding box, positioning it outside if necessary.
 */
CGRect MLRectFillInSizeIntegral(CGSize boundingSize, CGSize aspectSize) {
	CGRect rect = CGRectZero;
	rect.size.width = ceilf(boundingSize.height * aspectSize.width / aspectSize.height);
	if (rect.size.width >= boundingSize.width) {
		rect.size.height = boundingSize.height;
	} else {
		rect.size.width = boundingSize.width;
		rect.size.height = roundf(boundingSize.width * aspectSize.height / aspectSize.width);
	}
	
	rect.origin.x = floorf((boundingSize.width - rect.size.width) / 2.0f);
	rect.origin.y = floorf((boundingSize.height - rect.size.height) / 2.0f);
	
	
	return rect;
}

/*!
 @abstract Calculates the size of the rect that fills inside the bounding box.
 */
CGSize MLSizeFitInSize(CGSize boundingSize, CGSize aspectSize)
{
	CGSize size = aspectSize;
	if (size.height > boundingSize.height)
	{
		size.height = boundingSize.height;
		size.width = aspectSize.width * size.height / aspectSize.height;
	}
	if (size.width > boundingSize.width)
	{
		size.width = boundingSize.width;
		size.height = aspectSize.height * size.width / aspectSize.width;
	}
	
	return size;
}


/*!
 @abstract Just like \c MLSizeFitInSize, but flooring down the size.
 */
CGSize MLSizeFitInSizeIntegral(CGSize boundingSize, CGSize aspectSize)
{
	CGSize size = MLSizeFitInSize(boundingSize, aspectSize);
	return CGSizeMake(floorf(size.width), floorf(size.height));
}

// Centers a rect inside a bounding size
CGRect MLRectCenteredInSizeIntegral(CGSize boundingSize, CGSize insideSize)
{
	return CGRectMake(floorf((boundingSize.width - insideSize.width) / 2.0f),
					  floorf((boundingSize.height - insideSize.height) / 2.0f),
					  insideSize.width,
					  insideSize.height
					  );
}


/*!
 @abstract Centers a rect around a point.
 */
CGRect MLRectCenteredAtPointIntegral(CGPoint center, CGSize size)
{
	return CGRectMake(center.x - floorf(size.width / 2.0f),
					  center.y - floorf(size.height / 2.0f),
					  size.width,
					  size.height
					  );
}

/*!
 @abstract Calculates the size of the rect that fills inside the bounding box.
 */
CGRect MLRectFitInRect(CGRect boundingRect, CGSize aspectSize)
{
	// Calculates the fitting size -> centers it -> offset with original
	CGSize fitSize = MLSizeFitInSizeIntegral(boundingRect.size, aspectSize);
	CGRect centeredRect = MLRectCenteredInSizeIntegral(boundingRect.size, fitSize);
	return CGRectOffset(centeredRect, boundingRect.origin.x, boundingRect.origin.y);
}

#endif
