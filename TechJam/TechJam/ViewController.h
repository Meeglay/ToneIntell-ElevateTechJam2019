//
//  ViewController.h
//  TechJam
//
//  Created by Rahil Ali on 2019-09-21.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>

@interface ViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate, SFSpeechRecognizerDelegate>
@property(nonatomic) NSString* text;

@end

