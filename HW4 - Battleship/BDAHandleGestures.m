//
//  BDAHandleGestures.m
//  HW4 - Battleship
//
//  Created by Brian Alonso on 2/16/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import "BDAHandleGestures.h"


@implementation BDAHandleGestures {
    CGPoint currentPoint;
    CGFloat rotation, previousRotation;
    CGFloat scale, previousScale;
}

- (id)initWithImage:(UIImage *)image
{
	if (self = [super initWithImage:image])
		self.userInteractionEnabled = YES;
    
        // Add the rotation recognizer for the boat's ImageView
        UIRotationGestureRecognizer *rotationGesture =
        [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                     action:@selector(doRotate:)];
        rotationGesture.delegate = self;
        [self addGestureRecognizer:rotationGesture];

	return self;
}

#pragma mark - Gesture recognizers

- (void)transformImageView
{
    CGAffineTransform t = CGAffineTransformMakeScale(scale * previousScale,
                                                     scale * previousScale);
    t = CGAffineTransformRotate(t, rotation + previousRotation);
    self.transform = t;
}

- (void)doRotate:(UIRotationGestureRecognizer *)gesture
{
    rotation = gesture.rotation;
    [self transformImageView];
    
    NSLog(@"Handling rotation");
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        previousRotation = rotation + previousRotation;
        rotation = 0;
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // Ensure that we recognize rotate and drag
    return YES;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	// When a touch starts, get the current location in the view
	currentPoint = [[touches anyObject] locationInView:self];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	// Get active location upon move
	CGPoint activePoint = [[touches anyObject] locationInView:self];
    
	// Determine new point based on where the touch is now located
	CGPoint newPoint = CGPointMake(self.center.x + (activePoint.x - currentPoint.x),
                                   self.center.y + (activePoint.y - currentPoint.y));
    
	// Stay within the bounds of the parent view
	
    float midPointX = CGRectGetMidX(self.bounds);
    
	// Check if trying to drag off of the right screen boundary
    if (newPoint.x > self.superview.bounds.size.width  - midPointX)
        newPoint.x = self.superview.bounds.size.width - midPointX;
	else if (newPoint.x < midPointX)
        // Dont allow drag past left edge of screen
        newPoint.x = midPointX;
    
	float midPointY = CGRectGetMidY(self.bounds);
    
    // Check if trying to drag off the bottom of the screen
	if (newPoint.y > self.superview.bounds.size.height  - midPointY)
        newPoint.y = self.superview.bounds.size.height - midPointY;
	else if (newPoint.y < midPointY)
        // Top of screen
        newPoint.y = midPointY;
    
	// Set new center location
	self.center = newPoint;
}


@end
