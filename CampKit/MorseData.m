//
//  MorseData.m
//  CampKit
//
//  Created by Du Ha on 2/21/14.
//  Copyright (c) 2014 Du Ha. All rights reserved.
//

#import "MorseData.h"

@implementation MorseData

+(id)morseData
{
    return [MorseData singleton];
}

- (NSDictionary *)encodeData {
    if (!_encodeData) {
        _encodeData = [self loadData:@"MorseEndcodeData"];
    }
    return _encodeData;
}

- (NSDictionary*)loadData :(NSString *)fileName {
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

+ (MorseData *)singleton {
    static dispatch_once_t pred;
    static MorseData *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[MorseData alloc] init];
    });
    return shared;
}


@end
