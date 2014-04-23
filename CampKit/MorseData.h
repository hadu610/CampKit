//
//  MorseData.h
//  CampKit
//
//  Created by Du Ha on 2/21/14.
//  Copyright (c) 2014 Du Ha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MorseData : NSObject

@property (nonatomic, strong) NSDictionary *decodeData;
@property (nonatomic, strong) NSDictionary *encodeData;

+ (MorseData *)singleton;

+(id)morseData;

+ findMorse:(NSString *)morse;

@end

