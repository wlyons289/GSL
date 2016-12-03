//
//  ForcastManager.h
//  GSL
//
//  Created by William Lyons on 2016-12-02.
//  Copyright © 2016 William Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForcastDay.h"

@interface ForcastManager : NSObject

-(void)processData:(NSDictionary*)dict;
-(ForcastDay*)forcastForDayAtRow:(NSInteger)row;
-(NSInteger)count;

@end
