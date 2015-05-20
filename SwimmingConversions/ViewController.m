//
//  ViewController.m
//  SwimmingConversions
//
//  Created by Robert Lynch on 4/15/15.
//  Copyright (c) 2015 Robert Lynch Development. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

NSArray *_pickerData; //could divide this up into two arrays of raceTimes and raceStyles
NSString *convert;

double fullTime;
double doubleSeconds;
double doubleMinutes;
int doubleMiliseconds;
double convertedTime;

int convertedMinutes;
int convertedSeconds;
int convertedMiliseconds;



- (void)viewDidLoad
{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text doubleValue]/100;
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pickerData = @[@[@"50",@"100",@"200",@"NA"],@[@"Fly",@"Back",@"Breast",@"Free"]];
    /*[@"50 Free",@"100 Free", @"200 Free", @"100 Fly", @"200 Fly", @"100 Back", @"200 Back",@"100 Breast", @"200 Breast"];*/
    
    self.strokePicker.dataSource=self;
    self.strokePicker.delegate=self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
}


///////////////////////////////////////data source methods//////////////////////////////////////////////////////////////

-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _pickerData.count;
}
-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger) component
{
    return _pickerData[component][row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////delegate methods////////////////////////////////////////////////


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //You'll use this method to get the selected row and component number and use it to get the the appropriate method
    //maybe use a switch statement with the different methods for each case (index)...or something like this.
    //see http://nscookbook.com/2013/01/ios-programming-recipe-9-adding-multiple-columns-to-uipickerview/
    
    switch (row)
    {
        case 0:
            if(component==0){
                [self fiftyFlyConversion];
                self.output.text=convert;
            }
            else if (component==1){
                [self fiftyBackConversion];
                self.output.text=convert;
            }
            else if (component==2){
                [self fiftyBreastConversion];
                self.output.text=convert;
            }
            else if (component==3){
                [self fiftyFreeConversion];
                self.output.text=convert;
            }
            break;
        case 1:
            if(component==0){
                [self hundredFlyConversion];
                self.output.text=convert;
            }
            else if (component==1){
                [self hundredBackConversion];
                self.output.text=convert;
            }
            else if (component==2){
                [self hundredBreastConversion];
                self.output.text=convert;
            }
            else if (component==3){
                [self hundredFreeConversion];
                self.output.text=convert;
            }
            break;
        case 2:
            if(component==0){
                [self twoHundredFlyConversion];
                self.output.text=convert;
            }
            else if (component==1){
                [self twoHundredBackConversion];
                self.output.text=convert;
            }
            else if (component==2){
                [self twoHundredBreastConversion];
                self.output.text=convert;
            }
            else if (component==3){
                [self twoHundredFreeConversion];
                self.output.text=convert;
            }
            break;
        case 4:
            self.output.text=@"Thanks for using our App!";
            break;
            
        default:
            break;
    }

    
    // you also need a method like updateLabel to update the main label at the top with the converted data.
    //that would also be called here or in the actual conversion methods at the end
    
    
}

-(IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];      //You need a method that allows the user to dismiss the keyboard by tapping
                                        //anywhere on the screen if you're using a decimal keypad. Not required if you're going to use a standard qwerty keyboard. I think the former makes more sense.
}

- (IBAction)tweet:(id)sender
{
    
    
    /*
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"I love using this app!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }*/
    
    
    NSArray *activityItems;
    activityItems = @[self.output.text];
    
    //NSArray *activityActions;
    
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems: activityItems applicationActivities:nil];
    [self presentViewController:activityController
                       animated:YES completion:nil];
    
}




-(NSString *)fiftyFlyConversion{
    doubleMinutes = [self.minutes.text doubleValue]*60;
    doubleSeconds = [self.seconds.text doubleValue];
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=(fullTime*1.11+.7);
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+.7)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,convertedMiliseconds];
    return convert;
};
-(NSString *)hundredFlyConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    
    convertedTime=fullTime*1.11+1.4;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+1.4)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString *)twoHundredFlyConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+2.8;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+2.8)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString *)fiftyBackConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+.6;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+.6)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString *)hundredBackConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+1.2;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+1.2)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString *)twoHundredBackConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+2.4;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+2.4)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString*)fiftyBreastConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+1;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+1)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString*)hundredBreastConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+2;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+2)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString*)twoHundredBreastConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+3.2;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+3.2)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};
-(NSString*)fiftyFreeConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    
    convertedTime=fullTime*1.11+.8;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+.8)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
}
-(NSString *)hundredFreeConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+1.6;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+1.6)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};

-(NSString *)twoHundredFreeConversion{
    doubleMinutes = [self.minutes.text doubleValue];
    doubleSeconds = [self.seconds.text doubleValue]/60;
    doubleMiliseconds = [self.miliseconds.text intValue];
    fullTime=doubleMinutes+doubleSeconds+doubleMiliseconds;
    
    convertedTime=fullTime*1.11+3.2;
    convertedMinutes=(int)convertedTime/60;
    convertedSeconds=(int)convertedTime%60;
    convertedMiliseconds=(doubleMiliseconds*1.11+3.2)*10;
    
    convert=[NSString stringWithFormat:@"%d:%d.%d",convertedMinutes,convertedSeconds,doubleMiliseconds];
    return convert;
};

///////////This was the method needed to properly configure the webView//////////////////////


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showWebView"])
    {
        NSString *url = @"http://www.swimswam.com/news/";
        WebViewController *webVC = [segue destinationViewController];
        webVC.urlString = url; 
    
    }
}

@end




