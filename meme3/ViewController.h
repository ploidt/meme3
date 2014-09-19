//
//  ViewController.h
//  meme3
//
//  Created by Chanikarn Thavornwong on 9/14/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *imageView;
    float firstX;
    float firstY;
}

@property (weak, nonatomic) IBOutlet UITextField *TextF;
@property (weak, nonatomic) IBOutlet UIImageView *sticker;


- (IBAction)showActivityView:(UIBarButtonItem *)sender;
- (IBAction)btnCaptureImageClicked:(id)sender;
- (IBAction)TakePhoto;
- (IBAction)ChooseExisting;
- (IBAction)textFieldReturn:(id)sender;

@end
