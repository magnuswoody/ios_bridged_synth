//
//  Synth.h
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//


@import Foundation;
@import AVFoundation;

#import "Oscillator.h"

NS_ASSUME_NONNULL_BEGIN

@interface Synth : NSObject

@property (nonatomic, assign) float volume;
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (class, readonly) Synth *shared;

- (id)initWithSignal: (Signal)signal;
- (void)setWaveformTo: (Signal)signal;

@end

NS_ASSUME_NONNULL_END
