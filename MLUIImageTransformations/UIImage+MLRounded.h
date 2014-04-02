//
//  UIImage+MLRounded.h
//  MLUIImageTransformations
//
//  Created by Miguel Lara on 31/03/14.
//  Copyright (c) 2014 Miguel Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MLRounded)

/*!
 @abstract Creates a new image by masking the current image instance in a circle or an oval if the original image is not
 a square in size.
 @see -ml_roundedImageWithEdgeInsets:innerBorderColor:outerBorderColor:
 */
- (UIImage *)ml_roundedImage;

/*!
 @abstract Creates a new image with the same size as theby masking the current image instance in a circle or an oval if the original image is not
 a square in size. A custom inner and outer border can be defined.
 
 @code
  ______________________________________________ Original Size
 |                   ^                          |
 |        ___________|top ______  Final Size    |
 |       |  ______###v###______  |              |
 |       | |    ##@@@@@@@###   | |              |
 |       | | ##@@@       @@@## | |              |
 |       | |#@@             @@#| |              |
 |       |#|@                 @|#|              |
 |<------->|@                 @|<-------------->|
 | left  |#|@                 @|#|    right     |
 |       |#|@                 @|#|              |
 |       | |#@@             @@#| |              |
 |       | | ##@@@       @@@## | |              |
 |       | |   ###@@@@@@@###   | |              |
 |       |  ------###^###------  |              |
 |        -----------|-----------               |  @: Inner border
 |                   | bottom                   |  #: Outer border
 |___________________v__________________________|
 @endcode
 
 @param edgeInsets Edge of the border
 */
- (UIImage *)ml_roundedImageCropping:(UIEdgeInsets)cropEdgeInsets
					innerBorderColor:(UIColor *)innerBorderColor
							   width:(CGFloat)innerBorderWidth
					outerBorderColor:(UIColor *)outerBorderColor
							   width:(CGFloat)outerBorderWidth;

@end
