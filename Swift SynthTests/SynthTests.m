//
//  SynthTests.m
//  Swift SynthTests
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Synth.h"

@interface SynthTests : XCTestCase

@end

@implementation SynthTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSharedInstanceIsInstantiated {
    Synth* ref = [Synth shared];
    XCTAssertNotNil(ref);
}

- (void)testSharedInstanceInstiantedOnlyOnce {
    Synth* ref0 = [Synth shared];
    Synth* ref1 = [Synth shared];
    XCTAssertEqualObjects(ref0, ref1);
}

- (void)testVolumeSetterGetter {
    float expectedVolume = 0.5f;
    
    [Synth shared].volume = expectedVolume;
    XCTAssertEqual([Synth shared].volume, expectedVolume);
}

- (void)testIsPlayingToUser {
        
    float playingVolume = 0.5f;
    float mutedVolume = 0.0f;
    
    [Synth shared].volume = playingVolume;
    XCTAssertTrue([Synth shared].isPlaying);

    [Synth shared].volume = mutedVolume;
    XCTAssertFalse([Synth shared].isPlaying);
}

@end
