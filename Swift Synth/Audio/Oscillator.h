//
//  NSObject+Oscillator.h
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Oscillator : NSObject

@property (class) float amplitude;
@property (class) float frequency;

@end

NS_ASSUME_NONNULL_END
