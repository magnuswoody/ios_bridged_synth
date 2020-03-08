# Coding challenge

*See the original README below the additional comments I have added here.*

# Additional Information

## How would you generate 3 voices simultaneously using this synthesizer?

Using **additive synthesis**, the process of generating three voices is as simple as adding the resulting output of each wave (or `signal` output) for a given sample in time.

i.e. For time `t`, to produce a three voice synth the following three wave types could be added:
```
output(t) = sine(t) + square(t) + triangle(t)
```

This is of course generic and works for `1 -> N` oscillators (but of course depends on your computation power : this could become very expensive if implemented inefficiently).

To be precise in relating to this project, this would mean on the callback provided in our `AVAudioSourceNode`, instead of calculating one signal output based on time, multiple could be calculated.

One implementation could be the `Synth` object instance contains a list/array of oscillators and upon `AVAudioEngine` requesting a new block of audio, the output could be incrementally added by calculating the output for each signal based on time `t` (`self.time`).

```
float output = 0.0f;
for (osc* oscillator in Oscillators) {
    output += oscillator.signal(self.time)
}
```

This implementation would allow dynamic resizing of the oscillator bank, where each oscillator could have a different fundamental `frequency` and `amplitude`.

## Unit Testing

Where possible, the TDD (Test Driven Design) approach was used to help influence the API design and ensure highest test coverage, however this was just a simple implementation of what could be done in production.

It is also worth noting that I have implemented a performance test which can be run on device to check the speed of oscillator signal calculation. 

These tests can be run using the standard xcode unit test interface for XCTest.

## Development Devices

This was developed for an iPhone 11 with iOS 13.3.0, but was additionally tested on iPhone 11 simulator variations.

## Future improvements

If there was time for future improvements I have listed some below:
- Mocking of the AVAudioEngine to reduce the surface individual unit tests on the `Synth` class
- Different types of synthesis:
  - [Wavetable](http://www.aes.org/e-lib/browse.cfm?elib=7379) is usually more common for this purpose as it involves less OTF (on-the-fly) computation, but requires more memory reads (however this is usually better for non RTOS devices like iOS)
  - [Physical modelling](https://ccrma.stanford.edu/software/stk/) or [Granular](http://www.aes.org/e-lib/browse.cfm?elib=11144) synthesis to emulate more interesting sounds - especially with such a cool interface on iOS
- Smoothing:
  - A form of fading in between frequencies/amplitudes to avoid audible artefacts/crackles
  - Perhaps a larger lookahead buffer as well, since this doesn't require such minimal latency
- More optimized synthesis in software:
  - Looking towards generation in C++ with optimizations for each platform


These are just a few to explore if it was to go any further!

## End note

It was an interesting mini synth!

# Original README
## Introduction

This project contains a simple audio synthesizer written in Swift.
**Try it out and make yourself comfortable with the code!**

The heart of this project is in the `Synth.swift` file which contains the code
responsible for creating the sound (with help from `Oscillator.swift`)


## Todo

- Rewrite `Synth.swift` and `Oscillator.swift` in **Objective-C** and add it to this project
- Remove those two Swift files from the project and test it with your Obj-C implementation 
- They must work the same way as their counterpart in Swift
- Describe (not implement) how you would add the possibility to have 3 voices (synthesizers) at the same time

## Bonus

- Write a method in the `Synth.m` resp. `Synth.h` that informs the UI whenever audio is playing
- Display in the UI the String "Playing..." in some way when this method returns true, "" when it's false


## Rules

1. Create a repo on Github or Bitbucket and push this project (Don't fork!)
2. Make commits as often as possible! *(We want see what you do and how you do it)*
3. When you finish, send us the link to your repo by email
4. Please don't spend more than two hours on it! (1h should be fine)


### Why we use coding challenges to interview developers

Hiring is one of the most time-intensive and critical processes.
We know there are numbers of different approaches on this (and some pretty passionate opinions about it) but this approach works for us.
We first start with a coding challenge (like this one) in order to quickly evaluate the coding level of the candidate. Depending on the results of this challenge, we will invite you for more thorough interviews such as cultural fit and more technical knowledge. Recruiting is a mutual process. Feel free to ask us any questions as well.
Good luck!

What we want to evaluate with this coding challenge::

**Can you write any code?**
Basically, we need to see if you can write any code at all. We believe that you can. Still, there are many wantacoders out there and it's difficult to tell from a CV only.
Moreover, you’d be surprised how many candidates fall short when it’s time to put the cursor to the editor.

This is a pre-screening and we keep it really short. 1-2h should be fine for a skilled programmer to complete the task.
That's the only code you have to write. No online-challenges, coding puzzles or similar...
If we are happy with the result, we would like to invite you for further interviews on a personal level.

We know at some companies, it can be frustrating to send in coding challenges and never hear back from them anymore.
That's **not** how **we** work and think! So, you will get a feedback from us, no matter if we want to continue with you or not.

PROMISED!

Again, Good Luck!
The Pictural team
