//
//  BDASectorModel.h
//  HW4 - Battleship
//
//  Created by Brian Alonso on 2/16/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDASectorModel : NSObject {
    NSMutableArray* sectors;
    CGRect rectAircraftCarrier;
    CGRect rectCommandShip;
    CGRect rectSubmarine;
}

#define BLOCK_HEIGHT 53.0
#define BLOCK_WIDTH  53.0


@property (readonly) NSMutableArray* sectors;

@property (readonly) CGRect rectAircraftCarrier;
@property (readonly) CGRect rectCommandShip;
@property (readonly) CGRect rectSubmarine;
@end
