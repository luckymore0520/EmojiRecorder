#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "DollarP.h"


@protocol DollarPGestureResultDelegate <NSObject>
- (void)onResultGestured:(NSArray *)resultArray;
@end

@interface DollarPGestureRecognizer : UIGestureRecognizer {
    DollarP *dollarP;
    NSMutableDictionary *currentTouches;
    NSMutableArray *currentPoints;
    NSMutableArray *points;
    int strokeId;
}

@property (nonatomic, strong) NSMutableArray *pointClouds;
@property (nonatomic, strong, readonly) DollarResult *result;
@property (nonatomic, weak) id<DollarPGestureResultDelegate> dollarDelegate;
- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)recognize;
- (void)addGestureWithName:(NSString *)name;
- (NSArray *)points;

@end