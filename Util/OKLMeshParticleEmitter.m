//
//  OKLMeshParticleEmitter.m
//  OKLAnimation
//
//  Created by YanqingLee on 16/9/12.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import "OKLMeshParticleEmitter.h"

@implementation OKLMeshParticleEmitter
+ (void)snowOn:(UIViewController *)viewController {
    // Configure the particle emitter to the top edge of the screen
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(viewController.view.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize		= CGSizeMake(viewController.view.bounds.size.width * 2.0, 0.0);;
    
    // Spawn points for the flakes are within on the outline of the line
    snowEmitter.emitterMode		= kCAEmitterLayerOutline;
    snowEmitter.emitterShape	= kCAEmitterLayerLine;
    snowEmitter.preservesDepth = YES;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate		= 5;
    snowflake.lifetime		= 100.0;
    
    snowflake.velocity		= -10;				// falling down slowly
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 10;
    snowflake.emissionRange = 1 * M_PI;		// some variation in angle
    snowflake.spinRange		= 1 * M_PI;		// slow spin
    
    snowflake.contents		= (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    snowflake.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [viewController.view.layer insertSublayer:snowEmitter atIndex:0];
}
@end
