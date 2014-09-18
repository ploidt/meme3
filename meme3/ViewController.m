//
//  ViewController.m
//  meme3
//
//  Created by Chanikarn Thavornwong on 9/14/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)textFieldReturn:(id)sender
{
    [_TextF resignFirstResponder];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 250, 40)];
    myLabel.text = _TextF.text.uppercaseString;
    myLabel.textColor = [UIColor whiteColor];
    myLabel.font = [UIFont fontWithName:@"Arial" size:32];
    myLabel.shadowColor = [UIColor blackColor];
    myLabel.shadowOffset = CGSizeMake(-1, -1);
    [imageView addSubview:myLabel];
    [imageView setUserInteractionEnabled:YES];
    [myLabel setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    
    [myLabel addGestureRecognizer:panGesture];
    panGesture = nil;
    

}

- (IBAction)TakePhoto {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
    //[picker release];
}

- (IBAction)ChooseExisting {
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
    //[picker2 release];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)btnCaptureImageClicked:(id)sender
{
    [self createImage:imageView];
    
}

-(void)handlePanGesture:(id)sender
{
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
    }
    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    [[sender view] setCenter:translatedPoint];
    
}



-(UIImage *)createImage:(UIImageView *)imgView
{
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:context];
    UIImage *imgs = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(imgs,self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    return imgs;
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alertView;
    if(!error)
    {
        alertView=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your image has been saved successfully to your photo album." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else
    {
        alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Error Occured" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
