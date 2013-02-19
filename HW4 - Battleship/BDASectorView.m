//
//  BDASectorView.m
//  HW4 - Battleship
//
//  Created by Brian Alonso on 2/16/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import "BDASectorView.h"

@interface BDASectorView()

@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) UIColor *backgroundColor;

@end

@implementation BDASectorView {
    int rowNumber;
    int colNumber;
    NSString *rowLetter;
}
@synthesize rowLetter, colNumber;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame row:(int) rowNum  col:(int) colNum;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        rowNumber = rowNum;
        colNumber = colNum;
        rowLetter = self.rowLetters[rowNum];
        self.lineColor = [UIColor blackColor];
        self.backgroundColor =[UIColor lightGrayColor];
    }
    return self;
}

- (NSArray *)rowLetters
{
    NSString *letters = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
    return [letters componentsSeparatedByString:@" "];
}


#pragma mark - Draw the sector

- (void)drawRect:(CGRect)rect
{
    // Draw the grid sector box to the passed height and width
	float viewWidth = self.bounds.size.width;
	float viewHeight = self.bounds.size.height;
    
	//	Get the drawing context
	CGContextRef context =  UIGraphicsGetCurrentContext ();
	
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [self lineColor].CGColor);
    CGContextSetFillColorWithColor(context, [self backgroundColor].CGColor);
    
    // Define a rect in the shape of the square
    CGRect blockRect = CGRectMake(1, 1,  viewWidth, viewHeight);
    CGContextAddRect(context, blockRect);
    CGContextDrawPath(context, kCGPathFillStroke);

}

@end
