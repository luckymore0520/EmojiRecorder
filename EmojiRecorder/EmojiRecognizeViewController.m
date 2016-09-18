//
//  EmojiRecognizeViewController.m
//  EmojiRecorder
//
//  Created by WangKun on 16/9/16.
//  Copyright © 2016年 luckymore. All rights reserved.
//

#import "EmojiRecognizeViewController.h"
#import "GestureView.h"
#import "DollarDefaultGestures.h"
#import "DollarResult.h"
#import "DollarPGestureRecognizer.h"
#import "EmojiSelectionCollectionViewCell.h"

@interface EmojiRecognizeViewController ()<GestureViewDelegate,DollarPGestureResultDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet GestureView *gestureView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic, strong) DollarPGestureRecognizer *dollarPGestureRecognizer;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *recommandResultArray;
@end

@implementation EmojiRecognizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 4, 50);
    _dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(gestureRecognized:)];
    [_dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [_dollarPGestureRecognizer setDelaysTouchesEnded:NO];
    _dollarPGestureRecognizer.dollarDelegate = self;
    [_gestureView addGestureRecognizer:_dollarPGestureRecognizer];
    _gestureView.delegete = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)gestureRecognized:(DollarPGestureRecognizer *)sender {

}


- (IBAction)onSaveButtonClicked:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Emoji" message:@"Enter Your Emoji:" preferredStyle:UIAlertControllerStyleAlert];
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
    }];

    
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *emojiTextField = [controller textFields][0];
        if (emojiTextField.text.length > 0) {
            [_dollarPGestureRecognizer addGestureWithName:emojiTextField.text];
        }
    }]];
    
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)onCleanButtonClicked:(id)sender {
    [_gestureView clearAll];
    [_dollarPGestureRecognizer reset];
    _recommandResultArray = nil;
    [self.collectionView reloadData];
}

- (void)onResultGestured:(NSArray *)resultArray {
    self.recommandResultArray = resultArray;
    [self.collectionView reloadData];
}

- (void)onTouchEnd {
    [_dollarPGestureRecognizer recognize];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommandResultArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmojiSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiSelectionCollectionViewCell" forIndexPath:indexPath];
    DollarResult *result = self.recommandResultArray[indexPath.row];
    cell.textLabel.text = result.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DollarResult *result = self.recommandResultArray[indexPath.row];
    NSMutableString *str = [NSMutableString stringWithString:self.textField.text];
    [str appendString:result.name];
    self.textField.text = str;
    [self onCleanButtonClicked:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
