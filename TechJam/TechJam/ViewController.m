//
//  ViewController.m
//  TechJam
//
//  Created by Rahil Ali on 2019-09-21.
//  Copyright © 2019 Rahil Ali. All rights reserved.
//

#import "ViewController.h"
#import "AnalyzeViewController.h"

@interface ViewController ()  {
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    IBOutlet UIButton *stopButton;
    IBOutlet UIButton *playButton;
    SFSpeechRecognizer *speechRecognizer;
    SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
    SFSpeechRecognitionTask *recognitionTask;
    AVAudioEngine *audioEngine;
}
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *pathComponents = [NSArray arrayWithObjects:
//                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
//                               @"MyAudioMemo.m4a",
//                               nil];
//    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
//
//    // Setup audio session
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//
//    // Define the recorder setting
//    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
//
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
//    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
//
//    // Initiate and prepare the recorder
//    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
//    recorder.delegate = self;
//    recorder.meteringEnabled = YES;
//    [recorder prepareToRecord];
//
//

    // Initialize the Speech Recognizer with the locale, couldn't find a list of locales
    // but I assume it's standard UTF-8 https://wiki.archlinux.org/index.php/locale
    speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    // Set speech recognizer delegate
    speechRecognizer.delegate = self;
    
    // Request the authorization to make sure the user is asked for permission so you can
    // get an authorized response, also remember to change the .plist file, check the repo's
    // readme file or this project's info.plist
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                NSLog(@"Denied");
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                NSLog(@"Not Determined");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                break;
            default:
                break;
        }
    }];
    
}

- (IBAction)recordVoice:(id)sender {
    // Stop the audio player before recording
//    if (player.playing) {
//        [player stop];
//    }
//
//    if (!recorder.recording) {
//        AVAudioSession *session = [AVAudioSession sharedInstance];
//        [session setActive:YES error:nil];
//
//        // Start recording
//        [recorder record];
//        //[recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
//    } else {
//
//        // Pause recording
//        [recorder pause];
//        //[recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
//    }
    
    if (audioEngine.isRunning) {
        [audioEngine stop];
        [recognitionRequest endAudio];
    } else {
        [self startListening];
    }
}
- (IBAction)analyze:(id)sender {
    [audioEngine stop];
    [recognitionRequest endAudio];
//    [recorder stop];
//
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    [audioSession setActive:NO error:nil];
//
//    if (!recorder.recording){
//        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
//        [player setDelegate:self];
//        [player play];
//    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"analyze"])
    {
        // Get reference to the destination view controller
        AnalyzeViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        if (self.text.length == 0) {
            self.text = @"Hi, you've called Swish Bank, how may I help you? I'm a customer of your bank and I have some errors on my account details. What type of errors? Well my name is spelt incorrectly for a start, it's spelt c-l-a-r-k-e-s-o-n, it shouldn't have an e. Also my address is wrong, it shows my old address and only reached me because of a redirect. I can fix that for you, could I have your customer identification number. 32948322. Your customer pin number..Um, don't remember, I hardly ever use it.\nThat's fine, I am just going to have ask some security questions to verify you are the account holder. Date of birth?\n1/1/1975\nFavourite chess opening..\nSicilian\nMost disturbing childhood memory..\nAlmost drowning in a pond after going in to fetch a ball after Billy called me a chicken because I wouldn't go in because I couldn't swim.\nThat's not showing up on my system..\nSpending a weekend at Neverland Ranch.\nOkay, now let's go ahead and fix your details. Would you like to change the most disturbing childhood memory on our records?\nNo, come to think of it the duck pond was a walk in the park after Neverland.\nWhat is your new address?\n12 SeaWhack Ave Crichfield\nI'm sorry sir, that's not coming up as a valid address.\nIt's a new residential area..\nI'm sorry sir, it's not validating.\nWe only finished building about..\nIt's bank policy not to accept fictitious addresses. I am instructed by bank security policy to ask the following questions, are you a terrorist, sex offender, money launderer or professional athlete?\nNo..\nThe only option I have is to change your address status to homeless, I must warn you that it may impact your credit rating in a negative way. I suggest you move to a real address as quickly as possible.\nNo ... I'm not homeless, could you just leave it at the old address..\nI cannot undo an update sir. Once you are living at a valid address you can call back. Would you like to fix your other record problems now sir?\nMy surname, it doesn't have an E.\nThat has been corrected sir. I have replaced your surname.\nAnd I would like to merge my wife's account with mine.\nYour wife's account ID.\n94839382\nYour wife's security pin id.\nI don't know... Look why don't I just put her on.\nHi, it's Maureen here, I would like to merge my account with my husbands but I don't know my pin.\nDate of birth?\n10/9/1975\nI'm sorry that's not right.\nYes it is.\nNo it's not.\nTry 9/10/1975.\nCorrect. Favourite province of China.\nI've never been to China.\nCorrect. Most embarrassing teenage experience?\nLosing my swimming top in the pool during the school swim meet.\nRight, what can I do for you today?\nI would like to merge my account with my husband.\nMy records are showing that you have a different surname..\nI didn't change my name when we got married.\nAnd you are living at a different address? He is showing up as homeless. The bank will need some evidence that you are married.\nLook, this is ridiculous, you have my security identification and his, it's not up to you to decide whether or not we are married.\nNormally we allow account merges but in this case the target account is flagged as a potential terrorist, sex offender, money launderer or professional athlete due to irregularities in address change requests showing up in his history.\nWe have only move house once..\nSo you are not at your stated address?\nWell no, I'm at 12 SeaWhack Ave Crichfield\nI am instructed by bank security policy to ask the following questions, are you a terrorist, sex offender, money launderer or professional athlete?\nWell actually two of the four but I don't see how that's any of your business..\nI cannot merge your accounts due to your homeless status and declining credit status, not only doesn't your husband have a residential address but he keeps changing his surname..\nLook, my husband wants to talk to you again!\nI have just received a text message telling me that my visa card has been suspended?\nCustomer identification number?\nYou just spoke to me!\nI have just been speaking to a Maureen O'Sullivan. Unless you are Maureen I will require your Customer identification number?\nLook, this has been one long mistake, how about we just pretend I didn't call today and that I didn't find any mistakes on my record and you can just go back to the old record..\nI'm sorry sir, this conversation has been recorded for training purposes and may even be forwarded around the office for a laugh. I cannot remove this call from our records.\nCould we just go back to our old record? Please?\nI cannot go back to an unclean record. You flagged that record as incorrect on a previous call. Will that be all for today?\nCan I speak to a supervisor..\nI am the supervisor, they made us all supervisors, it streamlined the complaints process. Anything else for today? Would you like to speak to my line manager?\nYes! Please!\nThat's me as well! How can I help you? I'm also my performance manager and my career guidance councilor.\nNo .. I think you've done enough. I need to get to a bank to try and get some cash..\nJust a moment sir, yes my branch finder shows your fictitious address is right around the corner from our Chrichfield branch..\nYes! What street..\nAnd it wont open for another six months with that being a new area and all. Can I help you with anything else?\nNo, please, nothing else.\nThank you for your business. Goodbye Mr Clockson.\nClarkson ... that's Clarkson ... hello? Hello?";
        }
        
        if ([self.text characterAtIndex:self.text.length -1] != '.') {
            self.text = [self.text stringByAppendingString:@"."];
        }
        
        vc.text = self.text;
    }
}

/*!
 * @brief Starts listening and recognizing user input through the
 * phone's microphone
 */

- (void)startListening {
    
    // Initialize the AVAudioEngine
    audioEngine = [[AVAudioEngine alloc] init];
    
    // Make sure there's not a recognition task already running
    if (recognitionTask) {
        [recognitionTask cancel];
        recognitionTask = nil;
    }
    
    // Starts an AVAudio Session
    NSError *error;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    
    // Starts a recognition process, in the block it logs the input or stops the audio
    // process if there's an error.
    recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = audioEngine.inputNode;
    recognitionRequest.shouldReportPartialResults = YES;
    recognitionTask = [speechRecognizer recognitionTaskWithRequest:recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        BOOL isFinal = NO;
        if (result) {
            // Whatever you say in the microphone after pressing the button should be being logged
            // in the console.
            NSLog(@"RESULT:%@",result.bestTranscription.formattedString);
            self.text = result.bestTranscription.formattedString;
            isFinal = !result.isFinal;
        }
        if (error) {
            [audioEngine stop];
            [inputNode removeTapOnBus:0];
            recognitionRequest = nil;
            recognitionTask = nil;
        }
    }];
    
    // Sets the recording format
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    // Starts the audio engine, i.e. it starts listening.
    [audioEngine prepare];
    [audioEngine startAndReturnError:&error];
    NSLog(@"Say Something, I'm listening");
}
@end
