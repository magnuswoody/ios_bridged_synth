//
//  SynthUtilTypes.h
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#ifndef SynthUtilTypes_h
#define SynthUtilTypes_h

// Waveform type enum
typedef NS_ENUM(NSUInteger, Waveform) {
    sine,
    triangle,
    sawtooth,
    square,
    whiteNoise
};

// Define callback type
typedef float (^Signal)(float);

#endif /* SynthUtilTypes_h */
