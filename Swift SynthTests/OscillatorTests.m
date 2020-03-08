//
//  OscillatorTests.m
//  Swift SynthTests
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Oscillator.h"

@interface OscillatorTests : XCTestCase

@end

@implementation OscillatorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAmplitudeFrequencySettableGettable {
    
    float targetFrequency = 1000; // Hz
    float targetAmplitude = 0.5; // Linear Gain
    
    Oscillator.frequency = targetFrequency;
    
    XCTAssertEqual(Oscillator.frequency, targetFrequency);
    
    Oscillator.amplitude = targetAmplitude;
    
    XCTAssertEqual(Oscillator.amplitude, targetAmplitude);
}

@end
