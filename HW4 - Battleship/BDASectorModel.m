//
//  BDASectorModel.m
//  HW4 - Battleship
//
//  Created by Brian Alonso on 2/16/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import "BDASectorModel.h"
#import "BDASectorView.h"

@interface BDASectorModel()

@end

@implementation BDASectorModel {
    // Private ivars
}

@synthesize sectors, rectAircraftCarrier, rectCommandShip, rectSubmarine;

- (id)init {
    self = [super init];
    
    if (self) {
        // Init the grid array to hold the 36 sectors
        sectors = [[NSMutableArray alloc] initWithCapacity:36];
        
        BDASectorView* model;
        
        for (int row = 0; row<=5; row++)
        {
            for (int col = 0; col<=5; col++)
            {
                model = [[BDASectorView alloc ]
                      initWithFrame: CGRectMake(col * BLOCK_WIDTH ,
                                                row * BLOCK_HEIGHT,
                                                BLOCK_WIDTH, BLOCK_HEIGHT)
                                row:row
                                col:col+1];
                
                //	Add the tile to the view
                [sectors addObject:model];
            }
        }
    }
    
    return self;
}

@end
