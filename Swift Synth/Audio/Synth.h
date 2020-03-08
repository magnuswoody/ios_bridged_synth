//
//  NSObject+Synth.h
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SynthUtilTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Synth : NSObject

@property (nonatomic, assign) float volume;

+ (Synth*)shared;

- (id)init;

@end

NS_ASSUME_NONNULL_END
