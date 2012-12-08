//
//  GitExperimentViewController.m
//  GitExperiment
//
//  Created by Tim Hopmann on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// ADDING A COMMENT HERE TO SEE IF GIT PICKS IT UP


#import "GitExperimentViewController.h"

@interface GitExperimentViewController ()


@end

@implementation GitExperimentViewController

@synthesize myAudioPlayer = _myAudioPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)displayAlert:(id)sender {
    UIAlertView *alertView;
    
    // Get the URL for the sound file
    /*
    NSArray *tempURLs = [[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask]; // An array because it returns all matching directories in the domain -- but since this is my sandbox, I should only see one and it is in location 0 of the array (or "lastObject")
    self.agendaStorageURL = [tempURLs lastObject];
    self.agendaStorageURL = [self.agendaStorageURL URLByAppendingPathComponent:@"Agenda.dat"];
    */
     
    //NSURL *playURL = [[NSBundle mainBundle] resourceURL]; // Build URL for file to be copied from bundle
    //playURL = [playURL URLByAppendingPathComponent:@"Soothing.aif"];
    //(NSURL *) $1 = 0x0ae72aa0 file://localhost/Users/Tim/Library/Application%20Support/iPhone%20Simulator/5.1/Applications/3E35CFDF-F820-4A50-BD6C-24370BB905EC/GitExperiment.app/Soothing.aif
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Soothing" ofType:@"aif"];
    NSURL *playURL = [NSURL fileURLWithPath:soundPath];
    NSError *error;
    
    self.myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:playURL error:&error];
    NSLog(@"About to play sound, checking for error");
    if(error) {
        NSLog( @"%@", [error localizedDescription] );
    }
    
    
    self.myAudioPlayer.delegate = self;
    
    // Audio Session setup
    [[AVAudioSession sharedInstance] setDelegate: self];
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
    if (setCategoryError)
        NSLog(@"Error setting category! %@", setCategoryError);
    
    
    [self.myAudioPlayer prepareToPlay];
    bool success = [self.myAudioPlayer play];
    
    NSLog(@"I just played file %@", self.myAudioPlayer.url);
    if (!success) {
        NSLog(@"Failed to play file");
    } else NSLog(@"Looks like it succeded");
     
    
    
    alertView = [[UIAlertView alloc] initWithTitle:@"Hi Yourself!"
                                           message:@"I think you're grand"
                                          delegate:self
                                 cancelButtonTitle:@"I like you too"
                                 otherButtonTitles: nil];
    [alertView show];
                  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button clicked at index %d", buttonIndex);
}

/*
//To load sound file.
-(void) playSound:(NSString *)fileName {
	NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],fileName];
    
	//declare a system sound id
	SystemSoundID soundID;
    
	//Get a URL for the sound file
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    
	//Use audio sevices to create the sound
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
    
	//Use audio services to play the sound
	AudioServicesPlaySystemSound(soundID);
}
 */

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag == YES) {
        NSLog(@"Audio player played successfully");
    } else NSLog(@"Audio player failed");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"Player decode error");
}


@end
