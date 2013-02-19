//
//  BDAViewController.m
//  HW4 - Battleship
//
//  Created by Brian Alonso on 2/16/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import "BDAViewController.h"
#import "BDASectorModel.h"
#import "BDASectorView.h"
#import "BDAHandleGestures.h"

@interface BDAViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblSector;

@end

@implementation BDAViewController {
    BDASectorModel* gameModel;
    UIImageView *aircraftCarrier;
    UIImageView *commandship;
    UIImageView *submarine;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize the game model
    gameModel = [[BDASectorModel alloc] init];
    
    // Iterate over the sectors in the model, drawing them
    for (BDASectorView* sector in gameModel.sectors) {
        // Configure gesture recognizer for a tap for the view
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handleSectorTap:)];
        tap.numberOfTapsRequired = 1;
        [sector addGestureRecognizer:tap];
        
        //	Add the grid sector view to the view hierarchy
        [self.view addSubview:sector];
    }
    
    // Setup the carrier for dragging
    UIImage* imgCarrier = [UIImage imageNamed:@"aircraftcarrier.gif"];
    BDAHandleGestures *imgView = [[BDAHandleGestures alloc] initWithImage:imgCarrier];
    CGSize boatSize = [imgCarrier size];
    
    // Move the boat to the starting position
    imgView.center = CGPointMake(boatSize.width/2 + 5.0, boatSize.height/2 + 325.0);
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    // Add the Carrier to the game model
    aircraftCarrier = [[UIImageView alloc] initWithImage: imgCarrier];
    [aircraftCarrier setFrame:gameModel.rectAircraftCarrier];
    
    // Configure gesture recognizer for a tap for the view
    UITapGestureRecognizer *tapCarrier = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleBoatTap:)];
    tapCarrier.delegate = self;
    tapCarrier.numberOfTapsRequired = 1;
    [imgView addGestureRecognizer:tapCarrier];
    
    
    // Add the rotation recognizer for the Air Craft Carrier
//    UIRotationGestureRecognizer *rotationGesture =
//    [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(doRotate:)];
//    rotationGesture.delegate = self;
//    [aircraftCarrier addGestureRecognizer:rotationGesture];
    
    // Setup the Submarine for dragging
    UIImage* imgSubmarine = [UIImage imageNamed:@"submarine.gif"];
    imgView = [[BDAHandleGestures alloc] initWithImage:imgSubmarine];
    boatSize = [imgSubmarine size];
    
    // Move the boat to the starting position
    imgView.center = CGPointMake(boatSize.width/2 + 5.0, boatSize.height/2 + 385.0);
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    // Add the Submarine to the game model
    submarine = [[UIImageView alloc] initWithImage:imgSubmarine];
    [submarine setFrame:gameModel.rectSubmarine];
    
    // Setup the command ship for dragging
    UIImage* imgCommandShip = [UIImage imageNamed:@"commandship.gif"];
    imgView = [[BDAHandleGestures alloc] initWithImage:imgCommandShip];
    boatSize = [imgCommandShip size];
    
    // Move the boat to the starting position
    imgView.center = CGPointMake(boatSize.width/2 + 130.0, boatSize.height/2 + 385.0);
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    // Add the Command ship to the game model
    commandship = [[UIImageView alloc] initWithImage:imgCommandShip];
    [commandship setFrame:gameModel.rectCommandShip];

}

#pragma mark - Gesture recognizers

- (void)handleSectorTap:(UIGestureRecognizer *)gestureRecognizer
{
    BDASectorView *tappedSector = (BDASectorView*) gestureRecognizer.view;
    
    // Display the tapped sector's row and column in the label
    self.lblSector.text = [NSString stringWithFormat:@"%@%i", tappedSector.rowLetter, tappedSector.colNumber];
}


- (void)handleBoatTap:(UIGestureRecognizer *)gestureRecognizer
{
    
    CGPoint targetPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    // Search for an intersection with the sectors
    for (BDASectorView* sector in gameModel.sectors) {
        CGRect intersection = CGRectIntersection(sector.frame, [gestureRecognizer.view frame]);
        if(CGRectIsNull(intersection)) {
            // Not touching yet - null intersection
        }
        else
        {
            // Is the tap within a sector ?
            NSLog(@"Found part of a ship overlapping a sector !");
            
            CGPoint tapPoint = [gestureRecognizer.view convertPoint:targetPoint toView:sector.superview];
            if (CGRectContainsPoint(sector.frame, tapPoint))
            {
                NSLog(@"Found the sector !");
                
                // Display the tapped sector's row and column in the label
                self.lblSector.text = [NSString stringWithFormat:@"%@%i", sector.rowLetter, sector.colNumber];
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
