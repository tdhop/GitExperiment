//
//  GitExperimentViewController.h
//  GitExperiment
//
//  Created by Tim Hopmann on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface GitExperimentViewController : UIViewController <AVAudioPlayerDelegate>

@property (strong) AVAudioPlayer *myAudioPlayer;


- (IBAction)displayAlert:(id)sender;

@end
