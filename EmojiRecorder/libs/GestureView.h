#import <Foundation/Foundation.h>


@protocol GestureViewDelegate <NSObject>

- (void)onTouchEnd;

@end

@interface GestureView : UIView {
    NSMutableDictionary *currentTouches;
    NSMutableArray *completeStrokes;
}

@property (nonatomic, weak) id<GestureViewDelegate> delegete;

- (void)clearAll;

@end